class ActivityHandler
  include ParsingHelper
  include RequestHelper

  def initialize(json, account, options = {})
    @account = account
    @json    = json
    @options = options
  end

  def perform
    raise NotImplementedError
  end

  protected

  def recorded?
    record = Payload.find_by(id: @json['id'])

    if record.nil?
      Payload.create!(id: @json['id'], local: false, payload: @json) and return false
    else
      true
    end
  end
end
