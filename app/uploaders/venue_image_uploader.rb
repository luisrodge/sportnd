class VenueImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    # eager
    process :resize_to_fill => [360, 360]
    # cloudinary_transformation :quality => 70
  end

  version :normal do
    # eager
    process :resize_to_fill => [110, 110]
    # cloudinary_transformation :quality => 70
  end

  version :small do
    # eager
    process :resize_to_fill => [60, 60]
    # cloudinary_transformation :quality => 100
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
