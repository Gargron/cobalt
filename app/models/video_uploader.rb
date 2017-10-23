class VideoUploader < Shrine
  plugin :determine_mime_type
  plugin :activerecord
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :versions
  plugin :delete_raw
  plugin :processing
  plugin :add_metadata
  plugin :rack_response

  Attacher.validate do
    validate_mime_type_inclusion ['video/mp4', 'video/webm']
  end

  add_metadata do |io|
    movie = FFMPEG::Movie.new(io.path)

    {
      duration: movie.duration,
      bitrate: movie.bitrate,
      resolution: movie.resolution,
      frame_rate: movie.frame_rate,
    }
  end

  metadata_method :duration, :bitrate, :resolution, :frame_rate

  process(:store) do |io|
    raw      = io.download
    movie    = FFMPEG::Movie.new(raw.path)
    original = Tempfile.new(['original', '.mp4'], binmode: true)

    movie.transcode(original.path, video_codec: 'libx264', custom: %w(-movflags faststart -strict -2))
    raw.delete

    { original: original }
  end
end
