require "application_system_test_case"

class GymClassesTest < ApplicationSystemTestCase
  setup do
    @gym_class = gym_classes(:one)
    @trainer = trainers(:one)
  end

  test "visiting the index" do
    visit gym_classes_url
    assert_selector "h1", text: "Gym Classes"
  end

  test "should create gym class" do
    visit gym_classes_url
    click_on "New Gym Class"

    fill_in "Name", with: "New Test Class"
    
    # Use a simpler approach for the datetime selection
    select Date.current.year.to_s, from: "gym_class_schedule_1i"
    select Date.current.strftime('%B'), from: "gym_class_schedule_2i"
    select Date.current.day.to_s, from: "gym_class_schedule_3i"
    select "10", from: "gym_class_schedule_4i"
    select "30", from: "gym_class_schedule_5i"
    
    select @trainer.name, from: "gym_class[trainer_id]"
    click_on "Create Gym class"

    assert_text "Gym class was successfully created"
  end

  test "should update Gym class" do
    visit gym_class_url(@gym_class)
    click_on "Edit", match: :first

    fill_in "Name", with: @gym_class.name
    
    # Date fields are already populated, we don't need to fill them in again
    
    click_on "Update Gym class"

    assert_text "Gym class was successfully updated"
  end

  test "should destroy Gym class" do
    visit gym_class_url(@gym_class)
    click_on "Delete", match: :first
    
    # Accept alert
    page.driver.browser.switch_to.alert.accept rescue nil

    assert_text "Gym class was successfully destroyed"
  end
end
