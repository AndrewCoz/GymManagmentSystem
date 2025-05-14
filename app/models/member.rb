class Member < ApplicationRecord
  has_and_belongs_to_many :gym_classes
  
  # Default values
  before_validation :set_default_membership_type
  
  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :membership_type, presence: true, inclusion: { in: ['Basic', 'Premium', 'VIP'] }
  validates :join_date, presence: true
  
  private
  
  def set_default_membership_type
    self.membership_type ||= 'Basic'
  end
end
