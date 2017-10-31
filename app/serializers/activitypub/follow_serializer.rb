class ActivityPub::FollowSerializer < ActivityPub::ActivitySerializer
  attribute :target, key: :object

  def type
    'Follow'
  end

  def target
    TagManager.uri_for(object.target_account)
  end
end
