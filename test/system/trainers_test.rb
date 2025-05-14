require "application_system_test_case"

class TrainersTest < ApplicationSystemTestCase
  setup do
    @trainer = trainers(:one)
  end

  test "visiting the index" do
    visit trainers_url
    assert_selector "h1", text: "Trainers"
  end

  test "should create trainer" do
    visit trainers_url
    click_on "New Trainer"

    fill_in "Name", with: "New Test Trainer"
    fill_in "Email", with: "new.trainer@example.com"
    fill_in "Phone", with: @trainer.phone
    fill_in "Specialization", with: @trainer.specialization
    click_on "Create Trainer"

    assert_text "Trainer was successfully created"
    click_on "Back"
  end

  test "should update Trainer" do
    visit trainer_url(@trainer)
    click_on "Edit", match: :first

    fill_in "Name", with: @trainer.name
    fill_in "Email", with: @trainer.email
    fill_in "Phone", with: @trainer.phone
    fill_in "Specialization", with: @trainer.specialization
    click_on "Update Trainer"

    assert_text "Trainer was successfully updated"
    click_on "Back"
  end

  test "should destroy Trainer" do
    visit trainer_url(@trainer)
    click_button "Delete"
    
    # Accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept rescue nil

    assert_text "Trainer was successfully destroyed"
  end
end
