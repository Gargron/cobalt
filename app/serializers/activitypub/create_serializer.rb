class ActivityPub::CreateSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Create'
  end

  def target
    TagManager.uri_for(object)
  end
end
