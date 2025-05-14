class AddEmailToTrainers < ActiveRecord::Migration[8.0]
  def change
    add_column :trainers, :email, :string
  end
end
