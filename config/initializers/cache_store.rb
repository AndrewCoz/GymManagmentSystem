# Configure cache store based on environment variable
if ENV['RAILS_CACHE_STORE'] == 'null_store'
  Rails.application.config.cache_store = :null_store
elsif ENV['RAILS_CACHE_STORE'] == 'memory_store'
  Rails.application.config.cache_store = :memory_store, { size: 64.megabytes }
end 