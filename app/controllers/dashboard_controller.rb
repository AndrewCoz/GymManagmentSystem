class DashboardController < ApplicationController
  def index
    @total_members = Member.count
    @total_trainers = Trainer.count
    @total_classes = GymClass.count
    
    # Get upcoming classes for the next 7 days
    @upcoming_classes = GymClass.where('schedule >= ?', Time.current)
                               .order(schedule: :asc)
                               .includes(:trainer)
                               .limit(5)
  end
end 