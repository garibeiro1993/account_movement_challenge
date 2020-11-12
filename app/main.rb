require "active_record"
require "yaml"
require "money"

MONEY_ROUND = Money.rounding_mode = BigDecimal::ROUND_HALF_UP
DEFAULT_CURRENCY = Money.locale_backend = :currency

def file_config_db
  file = File.join(File.expand_path("..", __FILE__), "..", "db", "config.yml")
  YAML.load(File.read(file))
end

ActiveRecord::Base.establish_connection(file_config_db["development"])

    "Saldo final de #{Money.new(account.balance, "BRL").format} na conta #{account.id}"
