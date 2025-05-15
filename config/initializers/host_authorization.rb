# Disable host authorization in production since Back4App handles it at their load balancer
Rails.application.config.hosts = nil if Rails.env.production?

# Allow the Back4App domain specifically
Rails.application.config.hosts << ".b4a.run" if Rails.env.production?
Rails.application.config.hosts << ".back4app.io" if Rails.env.production?

# Also allow localhost for development and testing
Rails.application.config.hosts << "localhost" unless Rails.env.production? 