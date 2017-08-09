class AlbumImage < ApplicationRecord
  belongs_to :album

  # validate :image_name_size
  
  private 
    def image_name_size #VK : Need to put into common place and understand how to use it into multiple models.
      if image_name.size > 5.megabytes #Need to understand how you can get the size of image.
        errors.add(:image_name, "should be less than 5MB")
      end
    end

end
