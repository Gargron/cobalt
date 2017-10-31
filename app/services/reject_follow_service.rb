class RejectFollowService
  def call(rejecting_account, follower_account, payload)
    ActivityManager.create(rejecting_account, ActiveModelSerializers::SerializableResource.new(
      nil,
      serializer: ActivityPub::RejectSerializer,
      adapter: ActivityPubAdapter,
      actor: rejecting_account,
      payload: payload
    ).as_json)
  end
end
