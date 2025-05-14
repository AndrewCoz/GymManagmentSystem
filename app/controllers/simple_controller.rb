class SimpleController < ApplicationController
  skip_before_action :authenticate_user!, :verify_authenticity_token, raise: false
  
  def ping
    render json: { status: 'ok', message: 'pong', time: Time.now }
  end
end 