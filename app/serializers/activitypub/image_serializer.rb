class ActivityPub::ImageSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :type, :media_type, :url

  def type
    'Image'
  end

  def url
    upload_url(object.url)
  end

  def media_type
    object.mime_type
  end
end
