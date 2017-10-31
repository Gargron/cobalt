class ActivityHandler::Follow < ActivityHandler
  def perform
    return if recorded?

    target_account_uri = value_or_id(@json['object'])
    target_account     = TagManager.uri_to_resource(target_account_uri, Account)

    return if target_account.remote?

    AcceptFollowService.new.call(target_account, @account, @json)
  end
end
