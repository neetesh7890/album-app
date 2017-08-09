class Album < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :album_images, dependent: :destroy
  # validates :image_name, presence: true
  
end
