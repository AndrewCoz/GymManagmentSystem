class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_user!
  
  # Skip authentication for health checks and the welcome page
  skip_before_action :authenticate_user!, only: [:welcome, :health_check], if: -> { respond_to?(:authenticate_user!) }
  
  # Public welcome page
  def welcome
    render html: '<h1>Gym Management System</h1><p>Please log in to access the system.</p><a href="/users/sign_in">Sign In</a>'.html_safe
  end
  
  # Health check endpoint
  def health_check
    render plain: "OK", status: 200
  end
end
