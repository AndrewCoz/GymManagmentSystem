class GymClass < ApplicationRecord
  belongs_to :trainer
  has_and_belongs_to_many :members
  
  # Validations
  validates :name, presence: true
  validates :schedule, presence: true
  
  # Using validates_timeliness gem for better datetime validation
  # This provides more accurate and flexible date validations than custom methods
  validates_datetime :schedule, after: -> { Time.current }, 
                     after_message: "must be in the future"
end
