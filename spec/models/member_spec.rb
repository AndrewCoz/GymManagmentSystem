require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:gym_classes).through(:registrations) if Member.reflect_on_association(:gym_classes) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:member)).to be_valid
    end
  end
end 