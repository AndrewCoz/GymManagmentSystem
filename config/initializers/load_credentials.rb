# This initializer ensures credentials are properly loaded in production

if Rails.env.production?
  if ENV['RAILS_MASTER_KEY'].present?
    begin
      Rails.application.credentials.key
      Rails.logger.info "Credentials loaded successfully from RAILS_MASTER_KEY" if Rails.logger
    rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
      Rails.logger.error "Failed to load credentials with RAILS_MASTER_KEY: #{e.message}" if Rails.logger
      
      # If we have SECRET_KEY_BASE as a fallback, use it
      if ENV['SECRET_KEY_BASE'].present?
        Rails.logger.info "Using SECRET_KEY_BASE from environment" if Rails.logger
        Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE']
      else
        Rails.logger.error "No valid RAILS_MASTER_KEY or SECRET_KEY_BASE found. Setting a temporary one." if Rails.logger
        
        # As a last resort, generate a temporary one (NOT recommended for production)
        # This is a fallback to prevent the app from crashing
        require 'securerandom'
        ENV['SECRET_KEY_BASE'] = SecureRandom.hex(64)
        Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE']
      end
    end
  elsif ENV['SECRET_KEY_BASE'].present?
    Rails.logger.info "Using SECRET_KEY_BASE from environment (no RAILS_MASTER_KEY found)" if Rails.logger
    Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE']
  else
    Rails.logger.error "Neither RAILS_MASTER_KEY nor SECRET_KEY_BASE found in environment" if Rails.logger
    
    # As a last resort, generate a temporary one (NOT recommended for production)
    # This is a fallback to prevent the app from crashing
    require 'securerandom'
    ENV['SECRET_KEY_BASE'] = SecureRandom.hex(64)
    Rails.application.secrets.secret_key_base = ENV['SECRET_KEY_BASE']
  end
end 