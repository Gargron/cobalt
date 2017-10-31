class HeaderUploader < Shrine
  plugin :rack_file
  plugin :determine_mime_type
  plugin :activerecord
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :delete_raw
  plugin :remote_url, max_size: 2.megabytes

  Attacher.validate do
    validate_mime_type_inclusion %w[image/png image/jpeg]
    validate_max_size 2.megabytes
  end
end
