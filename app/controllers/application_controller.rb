class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # Authentication is completely disabled for this demo application
  # before_action :authenticate_user!, unless: -> { action_name.in?(['welcome', 'health_check']) }
  
  # Skip authentication for all actions
  # skip_before_action :authenticate_user!, raise: false, if: -> { respond_to?(:authenticate_user!) }
  
  # Public welcome page
  def welcome
    redirect_to dashboard_path
  end
  
  # Health check endpoint
  def health_check
    render plain: "OK", status: 200
  end
end
