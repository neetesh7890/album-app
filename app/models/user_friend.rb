class UserFriend < ApplicationRecord
  
  #Associations
  belongs_to :user, inverse_of: :user_friends
  belongs_to :friend, class_name: "User" #friend ka association user se
  
end
