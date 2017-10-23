class VideoSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :title, :resolution, :urls

  def duration
    object.file[:original].duration
  end

  def resolution
    object.file[:original].resolution
  end

  def urls
    {
      original: torrent_url(object),
      torrent: torrent_url(object, format: :torrent),
    }
  end
end
