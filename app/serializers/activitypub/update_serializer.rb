class ActivityPub::UpdateSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Update'
  end

  def target
    TagManager.uri_for(object)
  end
end
