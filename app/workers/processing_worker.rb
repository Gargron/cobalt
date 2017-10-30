class ProcessingWorker
  include Sidekiq::Worker

  def perform(account_id, body)
    logger.warn body
  end
end
