class Album < ApplicationRecord
  
  #Associations
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :album_images, dependent: :destroy, autosave: true
  # validates :image_name, presence: true
  
  attr_accessor :image_name
  mount_uploader :image_name, ImageNameUploader

  #Scopes
  scope :comments, -> { order('comment_count DESC') }
end
