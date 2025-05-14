require 'rails_helper'

RSpec.describe "Dashboard", type: :system do
  before do
    # Create some test data
    create(:member)
    create(:trainer)
    create(:gym_class)
    
    # Visit the dashboard page
    visit dashboard_path
  end

  it "displays the dashboard with statistics" do
    expect(page).to have_content("Gym Management Dashboard")
    expect(page).to have_content("Total Members")
    expect(page).to have_content("1") # One member created
    expect(page).to have_content("Total Trainers")
    expect(page).to have_content("Total Classes")
  end

  it "has quick action buttons" do
    expect(page).to have_link("Add New Member")
    expect(page).to have_link("Add New Trainer") 
    expect(page).to have_link("Schedule New Class")
  end

  it "has navigation links" do
    expect(page).to have_link("Dashboard")
    expect(page).to have_link("Members")
    expect(page).to have_link("Trainers")
    expect(page).to have_link("Gym Classes")
  end
end 