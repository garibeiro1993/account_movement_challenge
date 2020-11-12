require "csv"
require "active_record"
require_relative "../../models/transaction"
require_relative "../accounts/update"
require_relative "../application_operation"

module Operations
  module Transactions
    class Create < ApplicationOperation
      attr_reader :transactions_csv

      def initialize(transactions_csv)
        @transactions_csv = transactions_csv
      end

      def call
        validate_presence_csv
        parse_csv
        create_transactions!
        result
      end

      private

      def validate_presence_csv
        return add_error("File not found") if transactions_csv.blank?
        true
      end

      def parse_csv
        @transactions_csv = CSV.read(transactions_csv)
      end

      def create_transactions!
        begin
          transactions_csv.each do |transaction_csv|
            transaction = Transaction.new(
              account_id: transaction_csv[0],
              amount: transaction_csv[1],
            )

            if transaction.save!
              Operations::Accounts::Update.call(transaction)
            end
          end
        rescue StandardError => e
          add_error(e.message)
        end
      end

      def add_error(msg)
        @errors = msg
      end
    end
  end
end
