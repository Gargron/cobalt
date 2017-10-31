class ProcessingWorker
  include Sidekiq::Worker

  def perform(account_id, body)
    account = Account.find(account_id)
    json    = Oj.load(body, mode: :strict)

    ActivityManager.from_json(account, json)
  rescue Oj::ParseError
    nil
  end
end
