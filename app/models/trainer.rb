class Trainer < ApplicationRecord
  has_many :gym_classes, dependent: :destroy
  has_many :members, through: :gym_classes
  
  # Validations
  validates :name, presence: true
  validates :specialization, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
end
