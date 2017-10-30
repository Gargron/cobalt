class AvatarUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :activerecord
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :delete_raw
  plugin :processing
  plugin :remote_url, max_size: 500.kilobytes

  Attacher.validate do
    validate_mime_type_inclusion %w[image/png image/jpeg]
    validate_max_size 500.kilobytes
  end

  process(:cache) do |original|
    width, height = FastImage.size(original.path)

    if width == height
      original
    else
      size = [width, height].max
      crop!(original, size, size, 0, 0, gravity: 'Center')
    end
  end
end
