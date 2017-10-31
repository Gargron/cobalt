class ActivityPub::RejectSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Reject'
  end

  def target
    instance_options[:payload]
  end
end
