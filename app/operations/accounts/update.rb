require "csv"
require "active_record"
require_relative "../../models/account"
require_relative "../../models/transaction"
require_relative "../application_operation"

module Operations
  module Accounts
    class Update < ApplicationOperation
      def initialize(transaction)
        @transaction = transaction
      end

      def call
        update_account!
      end

      private

      def update_account!
        begin
          find_account_by(@transaction.account_id).tap do |account|
            account.balance = calc_balance(account.balance, @transaction.amount)
            account.save!
          end
        rescue StandardError => e
          add_error(e.message)
        end
      end

      def calc_balance(balance, transferred)
        current_balance = balance + transferred

        if current_balance.negative? && transferred.negative?
          current_balance -= 300
        else
          current_balance
        end
      end

      def find_account_by(id)
        Account.find_by(id: id)
      end

      def add_error(msg)
        @errors = msg
      end
    end
  end
end
