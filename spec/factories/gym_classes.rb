FactoryBot.define do
  factory :gym_class do
    name { Faker::Sports.sport + " Class" }
    description { Faker::Lorem.paragraph }
    schedule { Faker::Time.forward(days: 30, period: :morning).strftime("%I:%M %p") }
    duration_minutes { [30, 45, 60, 90].sample }
    max_capacity { rand(10..30) }
    association :trainer
  end
end 