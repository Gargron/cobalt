class ActivityPub::VideoSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :name, :content, :url, :duration,
             :published, :updated, :attributed_to, :preview,
             :to

  def id
    TagManager.uri_for(object)
  end

  def type
    'Video'
  end

  def name
    object.title
  end

  def content
    object.description
  end

  def published
    object.published_at.iso8601
  end

  def updated
    object.updated_at.iso8601
  end

  def duration
    "PT#{object.file[:original].duration.floor}S"
  end

  def attributed_to
    TagManager.uri_for(object.account)
  end

  def to
    'https://www.w3.org/ns/activitystreams#Public'
  end

  def url
    [
      { type: 'Link', href: torrent_url(object), media_type: object.file[:original].mime_type },
      { type: 'Link', href: torrent_url(object, format: :torrent), media_type: 'application/x-bittorrent' },
    ]
  end

  def preview
    { type: 'Link', href: upload_url(object.file[:thumbnail].url), media_type: 'image/png' }
  end
end
