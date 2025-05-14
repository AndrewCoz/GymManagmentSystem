FactoryBot.define do
  factory :trainer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    specialization { ['Yoga', 'Cardio', 'Weight Training', 'Pilates', 'Zumba'].sample }
    experience_years { rand(1..20) }
    certification { Faker::Educator.degree }
  end
end 