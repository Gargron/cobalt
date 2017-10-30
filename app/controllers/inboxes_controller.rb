class InboxesController < ApplicationController
  include HttpSignatureVerification

  def create
    if signed_request_account
      process_payload
      head 202
    else
      [signature_verification_failure_reason, 401]
    end
  end

  private

  def process_payload
    ProcessingWorker.perform_async(signed_request_account.id, body.force_encoding('UTF-8'))
  end
end
