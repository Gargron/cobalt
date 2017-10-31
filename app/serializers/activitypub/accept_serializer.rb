class ActivityPub::AcceptSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Accept'
  end

  def target
    instance_options[:payload]
  end
end
