class Comment < ApplicationRecord
  
  #Validations
  validates :comment_name, presence: true

  #Association
  belongs_to :commentable, polymorphic: true, counter_cache: :count
end
