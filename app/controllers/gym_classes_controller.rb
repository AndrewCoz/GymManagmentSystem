# app/controllers/gym_classes_controller.rb
class GymClassesController < ApplicationController
  before_action :set_gym_class, only: %i[show edit update destroy add_member remove_member]

  def index
    @gym_classes = GymClass.all # Fetch all gym classes
  end

  def show
  end

  def new
    @gym_class = GymClass.new
  end

  def create
    @gym_class = GymClass.new(gym_class_params)
    if @gym_class.save
      redirect_to @gym_class, notice: "Gym class was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @gym_class.update(gym_class_params)
      redirect_to @gym_class, notice: "Gym class was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @gym_class.destroy
    redirect_to gym_classes_path, notice: "Gym class was successfully destroyed."
  end
  
  def add_member
    @member = Member.find(params[:member_id])
    
    if @gym_class.members.include?(@member)
      redirect_to @gym_class, alert: "#{@member.name} is already enrolled in this class."
    else
      @gym_class.members << @member
      redirect_to @gym_class, notice: "#{@member.name} has been added to #{@gym_class.name}."
    end
  end
  
  def remove_member
    @member = Member.find(params[:member_id])
    
    if @gym_class.members.include?(@member)
      @gym_class.members.delete(@member)
      redirect_to @gym_class, notice: "#{@member.name} has been removed from #{@gym_class.name}."
    else
      redirect_to @gym_class, alert: "#{@member.name} is not enrolled in this class."
    end
  end

  private

  def set_gym_class
    @gym_class = GymClass.find(params[:id])
  end

  def gym_class_params
    params.require(:gym_class).permit(:name, :schedule, :trainer_id)
  end
end
