require "application_system_test_case"

class GymClassesTest < ApplicationSystemTestCase
  setup do
    @gym_class = gym_classes(:one)
  end

  test "visiting the index" do
    visit gym_classes_url
    assert_selector "h1", text: "Gym classes"
  end

  test "should create gym class" do
    visit gym_classes_url
    click_on "New gym class"

    fill_in "Name", with: @gym_class.name
    fill_in "Schedule", with: @gym_class.schedule
    fill_in "Trainer", with: @gym_class.trainer_id
    click_on "Create Gym class"

    assert_text "Gym class was successfully created"
    click_on "Back"
  end

  test "should update Gym class" do
    visit gym_class_url(@gym_class)
    click_on "Edit this gym class", match: :first

    fill_in "Name", with: @gym_class.name
    fill_in "Schedule", with: @gym_class.schedule.to_s
    fill_in "Trainer", with: @gym_class.trainer_id
    click_on "Update Gym class"

    assert_text "Gym class was successfully updated"
    click_on "Back"
  end

  test "should destroy Gym class" do
    visit gym_class_url(@gym_class)
    click_on "Destroy this gym class", match: :first

    assert_text "Gym class was successfully destroyed"
  end
end
