class UserDetail < ApplicationRecord
  belongs_to :user

  validates :address, presence: true
	validates :city, presence: true
	validates :pincode, presence: true,numericality: { only_integer: true}
  validates :phone, length: {is: 10},numericality: { only_integer: true}
end
