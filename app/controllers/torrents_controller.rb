class TorrentsController < ApplicationController
  before_action :set_video

  def show
    respond_to do |format|
      format.all do
        video = @video.file[:original]
        file  = video.to_io

        start_at, end_at = parse_range_header
        content_length = end_at - start_at + 1

        response.headers['Content-Range']  = "bytes #{start_at}-#{end_at}/#{video.size}"
        response.headers['Content-Length'] = content_length
        response.headers['Accept-Ranges']  = 'bytes'

        send_data partial_read(file, start_at, content_length), type: video.mime_type, status: 206
      end

      format.torrent { send_data create_torrent }
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def create_torrent
    piece_length = best_piece_length(@video.file[:original].size)
    pieces = []

    data = {
      'creation date': Time.now.to_i,

      'url-list': [
        [ torrent_url(@video) ]
      ],

      announce: [
        [ 'udp://tracker.leechers-paradise.org:6969' ],
        [ 'udp://tracker.coppersurfer.tk:6969' ],
        [ 'udp://tracker.opentrackr.org:1337' ],
        [ 'udp://explodie.org:6969' ],
        [ 'udp://tracker.empire-js.us:1337' ],
        [ 'wss://tracker.btorrent.xyz' ],
        [ 'wss://tracker.openwebtorrent.com' ],
        [ 'wss://tracker.fastcast.nz' ]
      ],

      info: {
        name: @video.file[:original].id,
        length: @video.file[:original].size,
      },
    }

    begin
      file = @video.file[:original].to_io

      begin
        pieces << Digest::SHA1.digest(file.read(piece_length))
      end until file.eof?
    ensure
      file.close
    end

    data[:info][:'piece length'] = piece_length
    data[:info][:pieces] = pieces.join

    data.bencode
  end

  def partial_read(file, start, length)
    IO.binread(file, length, start)
  end

  def parse_range_header
    matched = request.headers['range'].match(/bytes=(\d+)-(\d*)/)

    if matched
      [matched[1].to_i, matched[2].to_i]
    else
      [0]
    end
  end

  def best_piece_length(bytes)
    available = 2**14..2**22
    current   = bytes / 2**10

    available.bsearch { |x| x >= current }
  end
end
