require "active_record"
require "yaml"
require_relative "./operations/accounts/create"
require_relative "./operations/transactions/create"
require "money"
require "pry"

MONEY_ROUND = Money.rounding_mode = BigDecimal::ROUND_HALF_UP
DEFAULT_CURRENCY = Money.locale_backend = :currency

def file_config_db
  file = File.join(File.expand_path("..", __FILE__), "..", "db", "config.yml")
  YAML.load(File.read(file))
end

ActiveRecord::Base.establish_connection(file_config_db["development"])

Account.delete_all
Transaction.delete_all

perform_account_creation = Operations::Accounts::Create.call(ARGV[0])
perform_transaction_creation = Operations::Transactions::Create.call(ARGV[1])

if perform_account_creation.success? && perform_transaction_creation.success?
  bank_statement = Account.all.map do |account|
    "Saldo final de #{Money.new(account.balance, "BRL").format} na conta #{account.id}"
  end

  puts "\n\n\n\n\n\n\n\n\n\n\n\n"
  puts bank_statement
end
