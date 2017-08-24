class AlbumImage < ApplicationRecord

  #Association
  belongs_to :album

  #Uploader
  mount_uploader :image_name, AvatarUploader
end
