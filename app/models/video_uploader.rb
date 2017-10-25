class VideoUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :determine_mime_type
  plugin :activerecord
  plugin :logging, logger: Rails.logger
  plugin :validation_helpers
  plugin :versions
  plugin :delete_raw
  plugin :processing
  plugin :add_metadata
  plugin :recache

  Attacher.validate do
    validate_mime_type_inclusion ['video/mp4', 'video/webm']
  end

  add_metadata do |io, context|
    next if File.extname(io) == '.png'

    movie = FFMPEG::Movie.new(io.path)

    {
      duration: movie.duration,
      bitrate: movie.bitrate,
      resolution: movie.resolution,
      frame_rate: movie.frame_rate,
    }
  end

  metadata_method :duration, :bitrate, :resolution, :frame_rate

  process(:recache) do |io|
    raw   = io.download
    movie = FFMPEG::Movie.new(raw.path)
    thumb = Tempfile.new(['thumbnail', '.png'], binmode: true)

    movie.screenshot(thumb.path)
    raw.delete

    width, _ = FastImage.size(thumb.path)
    thumb    = resize_and_pad!(thumb, width, ((width / 16) * 9).floor, background: 'black', gravity: 'Center')

    { original: io, thumbnail: thumb }
  end

  process(:store) do |io|
    raw      = io[:original].download
    movie    = FFMPEG::Movie.new(raw.path)
    original = Tempfile.new(['original', '.mp4'], binmode: true)

    movie.transcode(original.path, video_codec: 'libx264', custom: %w(-movflags faststart -strict -2))
    raw.delete

    { original: original, thumbnail: io[:thumbnail] }
  end
end
