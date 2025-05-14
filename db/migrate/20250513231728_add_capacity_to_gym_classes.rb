class AddCapacityToGymClasses < ActiveRecord::Migration[8.0]
  def change
    add_column :gym_classes, :capacity, :integer
  end
end
