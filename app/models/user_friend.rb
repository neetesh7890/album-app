class UserFriend < ApplicationRecord
  belongs_to :user 
  
  belongs_to :friend, class_name: "User" #friend ka association user se
  
end
