require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "should create member" do
    visit members_url
    click_on "New Member"

    fill_in "Email", with: "new.test@example.com"
    fill_in "Join date", with: @member.join_date
    fill_in "Name", with: "New Test User"
    fill_in "Phone", with: "555-123-7890"
    select "Standard", from: "Membership type" if page.has_select?("Membership type")
    click_on "Create Member"

    assert_text "Member was successfully created"
    click_on "Back"
  end

  test "should update Member" do
    visit member_url(@member)
    click_on "Edit", match: :first

    fill_in "Email", with: @member.email
    fill_in "Join date", with: @member.join_date
    fill_in "Name", with: @member.name
    fill_in "Phone", with: @member.phone
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end

  test "should destroy Member" do
    visit member_url(@member)
    click_button "Delete"
    
    # Accept the confirmation dialog
    page.driver.browser.switch_to.alert.accept rescue nil

    assert_text "Member was successfully destroyed"
  end
end
