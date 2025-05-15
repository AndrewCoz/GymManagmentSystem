class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # First skip any authentication for our public pages, BEFORE setting authenticate_user!
  skip_before_action :authenticate_user!, only: [:welcome, :health_check], raise: false, if: -> { respond_to?(:authenticate_user!) }
  
  # Then set authentication for other actions
  before_action :authenticate_user!, unless: -> { action_name.in?(['welcome', 'health_check']) }
  
  # Public welcome page
  def welcome
    render html: '<div style="text-align: center; margin-top: 100px; font-family: Arial, sans-serif;">
                  <h1>Gym Management System</h1>
                  <p>Welcome to our Gym Management System! Please log in to access the system.</p>
                  <div style="margin-top: 20px;">
                    <a href="/users/sign_in" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">Sign In</a>
                  </div>
                </div>'.html_safe
  end
  
  # Health check endpoint
  def health_check
    render plain: "OK", status: 200
  end
end
