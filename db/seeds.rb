account = Account.new(username: 'admin', local: true)
account.uri = TagManager.uri_for(account)
account.save!
