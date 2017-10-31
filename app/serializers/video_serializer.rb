class VideoSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :title, :resolution, :description,
             :published, :published_at, :urls

  has_one :account

  def duration
    object.file.duration
  end

  def resolution
    object.file.resolution
  end

  def urls
    {
      original: torrent_url(object),
      torrent: torrent_url(object, format: :torrent),
      thumbnail: upload_url(object.thumbnail.url),
    }
  end
end
