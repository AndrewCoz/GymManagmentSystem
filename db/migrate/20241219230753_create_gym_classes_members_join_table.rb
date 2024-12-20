class CreateGymClassesMembersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :members, :gym_classes do |t|
      t.index :member_id
      t.index :gym_class_id
    end
  end
end
