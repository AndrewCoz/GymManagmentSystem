class GymClass < ApplicationRecord
  belongs_to :trainer
  has_and_belongs_to_many :members
end
