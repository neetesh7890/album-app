class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  process resize_to_fit: [300, 300]
  
  # version :resize do
  #   process resize_to_fit: [200, 200]
  #   # process :resize_to_limit => []
  # end

  version :size_135_180 ,:if => :album_image? do
    process resize_to_fit: [135, 180]
  end


  version :large ,:if => :large? do
    process resize_to_fit: [300, 300]
  end

  def large?(file_name)
    true if model.class.name == "User"
  end

  def album_image?(file_name)
    true if model.class.name == "AlbumImage"
  end

  # version :large do
  #   # debugger
  #   process resize_to_fit: [200, 200], :if => :album?
  #   # process :resize_to_limit => []
  # end

  # version :thumb do
    
  # end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   # debugger
  #   "original_#{model.avatar.file.extension}" if original_filename
  # end

  private
  # def image?(new_file)
  #   debugger
  #   self.file.content_type.include? 'image'
  # end

  # def user?(img)
  #   # debugger
  #   # image = MiniMagick::Image.open(img.file)
  #   # image[:height]
  #   true if model.class.name == "User"
  # end

  # def album?(img)
  #   # debugger
  #   true if model.class.name == "Album"
  # end
end
