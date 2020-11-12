require "active_record"
require "yaml"
require_relative "./operations/accounts/create"
require_relative "./operations/transactions/create"
require "money"

MONEY_ROUND = Money.rounding_mode = BigDecimal::ROUND_HALF_UP
DEFAULT_CURRENCY = Money.locale_backend = :currency

def file_config_db
  file = File.join(File.expand_path("..", __FILE__), "..", "db", "config.yml")
  YAML.load(File.read(file))
end

ActiveRecord::Base.establish_connection(file_config_db["development"])

perform_account_creation = Operations::Accounts::Create.call(ARGV[0])
perform_transaction_creation = Operations::Transactions::Create.call(ARGV[1])
    "Saldo final de #{Money.new(account.balance, "BRL").format} na conta #{account.id}"
