require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns the total counts" do
      # Create test data
      create(:member)
      create(:trainer)
      create(:gym_class)

      get :index
      
      expect(assigns(:total_members)).to eq(1)
      expect(assigns(:total_trainers)).to eq(1)
      expect(assigns(:total_classes)).to eq(1)
    end

    it "assigns the monthly data" do
      # Create test data
      create(:member)
      
      get :index
      
      expect(assigns(:members_by_month)).to be_a(Hash)
      expect(assigns(:classes_by_month)).to be_a(Hash)
    end
  end
end 