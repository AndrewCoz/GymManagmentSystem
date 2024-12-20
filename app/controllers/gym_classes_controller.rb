# app/controllers/gym_classes_controller.rb
class GymClassesController < ApplicationController
  before_action :set_gym_class, only: %i[show edit update destroy]

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
      redirect_to gym_classes_path, notice: "Gym class created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @gym_class.update(gym_class_params)
      redirect_to gym_classes_path, notice: "Gym class updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @gym_class.destroy
    redirect_to gym_classes_path, notice: "Gym class deleted successfully."
  end

  private

  def set_gym_class
    @gym_class = GymClass.find(params[:id])
  end

  def gym_class_params
    params.require(:gym_class).permit(:name, :schedule, :trainer_id)
  end
end
