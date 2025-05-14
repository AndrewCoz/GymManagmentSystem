# This initializer ensures credentials are properly loaded in production

if Rails.env.production?
  # Check for RAILS_MASTER_KEY first (preferred approach)
  if ENV['RAILS_MASTER_KEY'].present?
    begin
      # Just try to access the credentials to verify the master key works
      Rails.application.credentials.key
      Rails.logger.info "Credentials loaded successfully from RAILS_MASTER_KEY" if Rails.logger
    rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
      Rails.logger.error "Failed to load credentials with RAILS_MASTER_KEY: #{e.message}" if Rails.logger
      
      # If we have SECRET_KEY_BASE as a fallback, use it
      if ENV['SECRET_KEY_BASE'].present?
        Rails.logger.info "Using SECRET_KEY_BASE from environment" if Rails.logger
        # Modern way to set secret_key_base directly
        Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']
      else
        Rails.logger.error "No valid RAILS_MASTER_KEY or SECRET_KEY_BASE found. Setting a temporary one." if Rails.logger
        
        # As a last resort, generate a temporary one (NOT recommended for production)
        require 'securerandom'
        generated_key = SecureRandom.hex(64)
        ENV['SECRET_KEY_BASE'] = generated_key
        Rails.application.config.secret_key_base = generated_key
      end
    end
  # Fall back to SECRET_KEY_BASE if no master key
  elsif ENV['SECRET_KEY_BASE'].present?
    Rails.logger.info "Using SECRET_KEY_BASE from environment (no RAILS_MASTER_KEY found)" if Rails.logger
    Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE']
  else
    Rails.logger.error "Neither RAILS_MASTER_KEY nor SECRET_KEY_BASE found in environment" if Rails.logger
    
    # As a last resort, generate a temporary one (NOT recommended for production)
    require 'securerandom'
    generated_key = SecureRandom.hex(64)
    ENV['SECRET_KEY_BASE'] = generated_key
    Rails.application.config.secret_key_base = generated_key
    
    Rails.logger.warn "Generated temporary SECRET_KEY_BASE for this session. THIS IS NOT SECURE FOR PRODUCTION." if Rails.logger
  end
end 