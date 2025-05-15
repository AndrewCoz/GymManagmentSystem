# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Create demo trainers
trainers = [
  { name: 'John Smith', email: 'john@example.com', phone: '555-123-4567', specialization: 'Strength Training' },
  { name: 'Sarah Johnson', email: 'sarah@example.com', phone: '555-987-6543', specialization: 'Yoga' },
  { name: 'Michael Brown', email: 'michael@example.com', phone: '555-456-7890', specialization: 'Cardio' }
]

trainers.each do |trainer_data|
  Trainer.create!(trainer_data) rescue puts "Could not create trainer: #{trainer_data[:name]}"
end

# Create demo members
members = [
  { name: 'Alice Williams', email: 'alice@example.com', phone: '555-111-2222', join_date: 1.month.ago },
  { name: 'Bob Miller', email: 'bob@example.com', phone: '555-333-4444', join_date: 2.weeks.ago },
  { name: 'Carol Davis', email: 'carol@example.com', phone: '555-555-6666', join_date: 3.days.ago },
  { name: 'Dave Wilson', email: 'dave@example.com', phone: '555-777-8888', join_date: 1.week.ago },
  { name: 'Eve Taylor', email: 'eve@example.com', phone: '555-999-0000', join_date: 5.days.ago }
]

members.each do |member_data|
  Member.create!(member_data) rescue puts "Could not create member: #{member_data[:name]}"
end

# Create demo gym classes
tomorrow = Date.today + 1.day
next_week = Date.today + 1.week

gym_classes = [
  { name: 'Morning Yoga', schedule: tomorrow.to_datetime.change(hour: 9), trainer_id: Trainer.find_by(specialization: 'Yoga')&.id || Trainer.first&.id },
  { name: 'Afternoon Cardio', schedule: tomorrow.to_datetime.change(hour: 15), trainer_id: Trainer.find_by(specialization: 'Cardio')&.id || Trainer.first&.id },
  { name: 'Evening Strength', schedule: tomorrow.to_datetime.change(hour: 18), trainer_id: Trainer.find_by(specialization: 'Strength Training')&.id || Trainer.first&.id },
  { name: 'Weekend Bootcamp', schedule: next_week.to_datetime.change(hour: 10), trainer_id: Trainer.first&.id }
]

gym_classes.each do |class_data|
  GymClass.create!(class_data) rescue puts "Could not create gym class: #{class_data[:name]}"
end

# Associate members with classes
if Member.any? && GymClass.any?
  GymClass.all.each do |gym_class|
    # Add 2-3 random members to each class
    Member.all.sample(rand(2..3)).each do |member|
      gym_class.members << member rescue nil
    end
  end
end

puts "Seed data created successfully!"
