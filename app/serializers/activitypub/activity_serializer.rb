class ActivityPub::ActivitySerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :actor

  def id
    activity_url(instance_options[:actor], SecureRandom.uuid)
  end

  def type
    'Activity'
  end

  def actor
    TagManager.uri_for(instance_options[:actor])
  end
end
