# Disable Devise authentication for the demo app
if defined?(Devise)
  # Make Devise authentication optional for all controllers
  Devise.setup do |config|
    config.skip_session_storage = [:http_auth, :params_auth]
    config.navigational_formats = ['*/*', :html, :turbo_stream, :json]
    
    # Allow access without confirmation
    config.allow_unconfirmed_access_for = 999.days
    
    # force_ssl belongs to Rails config, not Devise
    # config.force_ssl = false
  end
  
  # Monkey patch Devise to skip authentication
  module Devise
    module Controllers
      module Helpers
        def authenticate_user!(opts = {})
          # Skip authentication
        end
        
        def user_signed_in?
          # Always return true
          true
        end
        
        def current_user
          # Return a dummy user object
          OpenStruct.new(id: 1, email: 'demo@example.com', name: 'Demo User')
        end
      end
    end
  end
end 