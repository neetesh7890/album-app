class Album < ApplicationRecord
  
  #Associations
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy, autosave: true
  has_many :album_images, dependent: :destroy, autosave: true
  # validates :image_name, presence: true
  
  #Scopes
  scope :comments, -> { order('comment_count DESC') }

  mount_uploader :image_name, AvatarUploader
end
