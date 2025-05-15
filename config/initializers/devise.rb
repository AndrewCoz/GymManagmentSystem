Devise.setup do |config|
  # ... existing code ...

  # Allow access to certain routes without authentication in production
  config.allow_unconfirmed_access_for = 30.days if Rails.env.production?
  # Skip forcing SSL in development and test
  config.force_ssl = false unless Rails.env.production?
  # Allow HTTP on Back4App since they handle HTTPS at their load balancer
  config.navigational_formats = ['*/*', :html, :json]
end 