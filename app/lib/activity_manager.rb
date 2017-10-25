class ActivityManager
  class << self
    def create(type, object)
      data = ActiveModelSerializers::SerializableResource.new(
        object,
        serializer: ActivityPub::ActivitySerializer,
        adapter: ActivityPubAdapter,
        type: type.to_s.capitalize,
        actor: object_owner(object)
      ).as_json

      ApplicationRecord.transaction do
        payload = Payload.create!(id: data[:id], payload: data, local: true)
        Activity.create!(account: object_owner(object), payload: payload)
      end
    end

    private

    def object_owner(object)
      return object if object.class.name == 'Account'
      raise ArgumentError unless object.respond_to?(:account)

      object.account
    end
  end
end
