class HealthController < ActionController::Base
  # Skip any authentication or database-dependent filters
  skip_before_action :verify_authenticity_token, raise: false
  
  def check
    render plain: "OK", status: 200
  end
end 