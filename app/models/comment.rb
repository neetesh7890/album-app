class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  validates :comment_name, presence: true
end
