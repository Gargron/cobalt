class UndoFollowService
  def call(account, target_account)
    @object = Follow.find_by!(account: account, target_account: target_account)
    ActivityManager.create(account, payload)
    @object.destroy!
  end

  private

  def payload
    ActiveModelSerializers::SerializableResource.new(
      @object,
      serializer: ActivityPub::UndoSerializer,
      adapter: ActivityPubAdapter,
      actor: @object.account,
      payload: @object.payload.payload
    ).as_json
  end
end
