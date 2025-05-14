# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_13_233700) do
  create_table "gym_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "schedule"
    t.integer "trainer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity"
    t.index ["trainer_id"], name: "index_gym_classes_on_trainer_id"
  end

  create_table "gym_classes_members", id: false, force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "gym_class_id", null: false
    t.index ["gym_class_id"], name: "index_gym_classes_members_on_gym_class_id"
    t.index ["member_id"], name: "index_gym_classes_members_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "membership_type"
    t.date "join_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainers", force: :cascade do |t|
    t.string "name"
    t.string "specialization"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  add_foreign_key "gym_classes", "trainers"
end
