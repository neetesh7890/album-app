class UserFriend < ApplicationRecord
  
  #Associations
  belongs_to :user, inverse_of: :user_friends
  belongs_to :friend, class_name: "User" #friend ka association user se
  

  # after_destroy :delete_dependent

  # def delete_dependent
  #   UserFriend.where(token: self.token).destroy_all
  # end
end
