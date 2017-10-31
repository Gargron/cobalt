class FollowService
  def call(account, target_account)
    @object = Follow.new(account: account, target_account: target_account)
    @object.payload = ActivityManager.create(account, payload)
    @object.save!
  end

  private

  def payload
    ActiveModelSerializers::SerializableResource.new(
      @object,
      serializer: ActivityPub::FollowSerializer,
      adapter: ActivityPubAdapter,
      actor: @object.account
    ).as_json
  end
end
