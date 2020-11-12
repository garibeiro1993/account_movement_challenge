require "csv"
require "active_record"
require_relative "../../models/transaction"
require_relative "../accounts/update"
require_relative "../application_operation"

module Operations
  module Transactions
    class Create < ApplicationOperation
      def initialize(transactions_csv)
        @transactions_csv = CSV.read(transactions_csv)
      end

      def call
        remove_all_transactions
        create_transactions!
        result
      end

      private

      def validate
        return add_error("File not found") if @transactions_csv.nil?
      end

      def remove_all_transactions
        Transaction.delete_all
      end

      def create_transactions!
        begin
          @transactions_csv.each do |transaction_csv|
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
