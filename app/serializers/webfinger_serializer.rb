class WebfingerSerializer < ActiveModel::Serializer
  include RoutingHelper

  attributes :subject, :aliases, :links

  def subject
    TagManager.uri_for(object)
  end

  def aliases
    ["acct:#{object.username}@#{Rails.configuration.x.local_domain}"]
  end

  def links
    [
      { rel: 'http://webfinger.net/rel/profile-page', type: 'text/html', href: TagManager.uri_for(object) },
      { rel: 'self', type: 'application/activity+json', href: TagManager.uri_for(object) },
    ]
  end
end
