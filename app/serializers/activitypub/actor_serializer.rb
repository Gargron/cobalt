class ActivityPub::ActorSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :preferred_username, :name,
             :inbox, :outbox, :manually_approves_followers,
             :following, :followers

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

  def inbox
    nil
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
end
