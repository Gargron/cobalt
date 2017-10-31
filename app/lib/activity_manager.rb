class ActivityManager
  class << self
    def create(account, data)
      payload = nil

      ApplicationRecord.transaction do
        payload = Payload.create!(id: data[:id], payload: data, local: true)
        Activity.create!(account: account, payload: payload)
      end

      DistributionWorker.perform_async(account.id, payload.id)
      payload
    end

    def from_json(account, json)
      handler = klass_for_type(json['type']).new(account, json)
      handler.perform
    end

    private

    def object_owner(object)
      return object if object.class.name == 'Account'
      raise ArgumentError unless object.respond_to?(:account)

      object.account
    end

    def klass_for_type(type)
      case type
      when 'Create'
        # TODO
      when 'Delete'
        # TODO
      when 'Follow'
        ActivityHandler::Follow
      when 'Like'
        # TODO
      when 'Undo'
        # TODO
      when 'Accept'
        # TODO
      when 'Reject'
        # TODO
      end
    end
  end
end
