class UserDetail < ApplicationRecord
  
  #Validations
  validates :address, presence: true
	validates :city, presence: true
	validates :pincode, presence: true,numericality: { only_integer: true}
  validates :phone, length: {is: 10},numericality: { only_integer: true}

  #Associations
  belongs_to :user

end
