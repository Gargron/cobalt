class ActivityPub::DeleteSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Delete'
  end

  def target
    TagManager.uri_for(object)
  end
end
