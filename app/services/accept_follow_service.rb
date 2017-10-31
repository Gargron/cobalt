class AcceptFollowService
  def call(accepting_account, follower_account, payload)
    Follow.create!(account: follower_account, target_account: accepting_account, payload_id: payload['id'])

    ActivityManager.create(accepting_account, ActiveModelSerializers::SerializableResource.new(
      nil,
      serializer: ActivityPub::AcceptSerializer,
      adapter: ActivityPubAdapter,
      actor: accepting_account,
      payload: payload
    ).as_json)
  end
end
