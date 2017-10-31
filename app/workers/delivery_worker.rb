class DeliveryWorker
  include Sidekiq::Worker

  HEADERS = { 'Content-Type' => 'application/activity+json' }.freeze

  def perform(account_id, payload, inbox_url)
    @json           = Oj.dump(payload)
    @source_account = Account.find(account_id)
    @inbox_url      = inbox_url

    perform_request!
  end

  private

  def build_request
    request = Request.new(:post, @inbox_url, body: @json)
    request.on_behalf_of(@source_account)
    request.add_headers(HEADERS)
  end

  def perform_request!
    @response = build_request.perform
    @response.connection&.close
  end
end
