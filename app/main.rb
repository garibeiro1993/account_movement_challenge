require "active_record"
require "yaml"
def file_config_db
  file = File.join(File.expand_path("..", __FILE__), "..", "db", "config.yml")
  YAML.load(File.read(file))
end

ActiveRecord::Base.establish_connection(file_config_db["development"])
