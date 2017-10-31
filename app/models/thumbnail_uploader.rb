class ThumbnailUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :rack_file
  plugin :determine_mime_type
  plugin :activerecord
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :delete_raw
  plugin :remote_url, max_size: 2.megabytes
  plugin :processing

  Attacher.validate do
    validate_mime_type_inclusion %w[image/png image/jpeg]
  end

  process(:cache) do |original|
    width, height = FastImage.size(original.path)
    new_height    = ((width / 16) * 9).floor

    if height == new_height
      original
    else
      crop!(original, width, new_height, 0, 0, gravity: 'Center')
    end
  end
end
