class DashboardController < ApplicationController
  # Skip authentication
  skip_before_action :authenticate_user!, raise: false, if: -> { respond_to?(:authenticate_user!) }
  
  def index
    # Get count of members
    @total_members = Member.count rescue 0
    
    # Get count of trainers
    @total_trainers = Trainer.count rescue 0
    
    # Get count of gym classes
    @total_classes = GymClass.count rescue 0
    
    # Get recent gym classes 
    @upcoming_classes = GymClass.where('schedule >= ?', Time.current)
                                .order(schedule: :asc)
                                .includes(:trainer)
                                .limit(5) rescue []
    
    # Get member distribution data for chart
    @member_by_month = Member.group_by_month(:created_at, last: 6).count rescue {}
  end
end 