class Trainer < ApplicationRecord
  has_many :gym_classes
  has_many :members, through: :gym_classes
end
