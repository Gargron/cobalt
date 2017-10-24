class ActivityPub::ActorSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :preferred_username, :name,
             :inbox, :outbox

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
    nil
  end
end
