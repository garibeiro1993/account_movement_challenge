require "csv"
require "active_record"
require_relative "../../models/account"
require_relative "../application_operation"

module Operations
  module Accounts
    class Create < ApplicationOperation
      attr_reader :accounts_csv

      def initialize(accounts_csv)
        @accounts_csv = accounts_csv
      end

      def call
        validate_presence_csv
        parse_csv
        remove_duplicated_account
        create_accounts!
        result
      end

      private

      def validate_presence_csv
        return add_error("File not found") if accounts_csv.blank?
        true
      end

      def parse_csv
        @accounts_csv = CSV.read(accounts_csv)
      end

      def remove_duplicated_account
        @accounts_csv = accounts_csv.uniq { |account| account.first }
      end

      def remove_all_accounts
        Account.delete_all
      end

      def create_accounts!
        begin
          accounts_csv.each do |account|
            Account.new(id: account[0], balance: account[1]).save!
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
