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

Trainer.create([
  { name: "John Doe", specialization: "Strength Training", phone: "1234567890" },
  { name: "Jane Smith", specialization: "Yoga", phone: "0987654321" }
])

Member.create([
  { name: "Alice", email: "alice@example.com", phone: "5551234567", membership_type: "Monthly", join_date: Date.today },
  { name: "Bob", email: "bob@example.com", phone: "5557654321", membership_type: "Yearly", join_date: Date.today }
])

GymClass.create([
  { name: "Morning Yoga", schedule: DateTime.now + 1.day, trainer: Trainer.first },
  { name: "Evening Strength", schedule: DateTime.now + 2.days, trainer: Trainer.last }
])
