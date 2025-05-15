class DashboardController < ApplicationController
  # Skip authentication
  skip_before_action :authenticate_user!, raise: false, if: -> { respond_to?(:authenticate_user!) }
  
  def index
    # Get count of members
    @members_count = Member.count rescue 0
    
    # Get count of trainers
    @trainers_count = Trainer.count rescue 0
    
    # Get count of gym classes
    @gym_classes_count = GymClass.count rescue 0
    
    # Get recent gym classes (last 5)
    @recent_gym_classes = GymClass.order(created_at: :desc).limit(5) rescue []
    
    # Get member distribution data for chart
    @member_by_month = Member.group_by_month(:created_at, last: 6).count rescue {}
  end
end 