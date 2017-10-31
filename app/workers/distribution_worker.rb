class DistributionWorker
  include Sidekiq::Worker

  def perform(account_id, payload_id)
    account = Account.find(account_id)
    payload = Payload.find(payload_id)

    account.followers.find_each do |follower|
      DeliveryWorker.perform_async(account.id, payload.payload, follower.inbox_url)
    end
  end
end
