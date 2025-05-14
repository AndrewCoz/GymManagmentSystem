FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
    membership_type { ['Basic', 'Premium', 'Gold'].sample }
    membership_start_date { Date.today - rand(1..365).days }
    membership_end_date { Date.today + rand(30..365).days }
  end
end 