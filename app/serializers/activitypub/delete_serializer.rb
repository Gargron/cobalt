class ActivityPub::DeleteSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :actor
  attribute :target, key: :object

  def id
    activity_url(object.account, SecureRandom.uuid)
  end

  def type
    'Delete'
  end

  def actor
    TagManager.uri_for(object.account)
  end

  def target
    TagManager.uri_for(object)
  end
end
