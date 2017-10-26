class ActivityPub::ActorSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :preferred_username, :name, :url,
             :inbox, :outbox, :manually_approves_followers,
             :following, :followers, :endpoints

  has_one :icon,  serializer: ActivityPub::ImageSerializer, if: :avatar_exists?
  has_one :image, serializer: ActivityPub::ImageSerializer, if: :header_exists?

  def id
    TagManager.uri_for(object)
  end

  def type
    'Person'
  end

  def preferred_username
    object.username
  end

  def name
    object.display_name
  end

  def url
    TagManager.uri_for(object)
  end

  def inbox
    inbox_url(object)
  end

  def outbox
    outbox_url(object)
  end

  def following
    nil
  end

  def followers
    nil
  end

  def manually_approves_followers
    false
  end

  def endpoints
    { shared_inbox: shared_inbox_url }
  end

  def icon
    object.avatar
  end

  def image
    object.header
  end

  def avatar_exists?
    false
  end

  def header_exists?
    false
  end
end
