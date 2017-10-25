class ActivityPub::OutboxSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :id, :type, :total_items, :ordered_items

  def id
    outbox_url(object)
  end

  def type
    'OrderedCollection'
  end

  def total_items
    object.activities.count
  end

  def ordered_items
    object.activities.joins(:payload).select('activities.*, payloads.payload AS data').map(&:data)
  end
end
