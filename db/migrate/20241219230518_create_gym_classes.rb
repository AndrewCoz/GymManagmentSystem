class CreateGymClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :gym_classes do |t|
      t.string :name
      t.datetime :schedule
      t.references :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
