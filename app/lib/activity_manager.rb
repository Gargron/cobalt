class ActivityManager
  class << self
    def create(type, object)
      data = ActiveModelSerializers::SerializableResource.new(
        object,
        serializer: serializer_for_type(type),
        adapter: ActivityPubAdapter
      ).as_json

      ApplicationRecord.transaction do
        payload = Payload.create!(id: data[:id], payload: data, local: true)
        Activity.create!(account: object.account, payload: payload)
      end
    end

    private

    def serializer_for_type(type)
      case type
      when :create
        ActivityPub::CreateSerializer
      when :delete
        ActivityPub::DeleteSerializer
      else
        raise ArgumentError
      end
    end
  end
end
