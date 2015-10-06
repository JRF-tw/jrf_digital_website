require 'rabl'
Rabl.configure do |config|
  config.cache_sources = Rails.env != 'development'
  config.enable_json_callbacks = true
end