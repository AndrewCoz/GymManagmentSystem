class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :membership_type
      t.date :join_date

      t.timestamps
    end
  end
end
