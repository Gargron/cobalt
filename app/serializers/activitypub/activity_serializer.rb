class ActivityPub::ActivitySerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :actor
  attribute :target, key: :object

  def id
    activity_url(instance_options[:actor], SecureRandom.uuid)
  end

  def type
    instance_options[:type]
  end

  def actor
    TagManager.uri_for(instance_options[:actor])
  end

  def target
    TagManager.uri_for(object)
  end
end
