class AccountSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :username, :display_name,
             :avatar, :header, :url

  def url
    TagManager.uri_for(object)
  end

  def avatar
    object.avatar&.exists? ? upload_url(object.avatar.url) : nil
  end

  def header
    object.header&.exists? ? upload_url(object.header.url) : nil
  end
end
