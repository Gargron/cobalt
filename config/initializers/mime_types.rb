# Be sure to restart your server when you modify this file.

Mime::Type.register 'application/x-bittorrent', :torrent
Mime::Type.register 'application/json', :json, %w(text/x-json application/jsonrequest application/jrd+json application/activity+json application/ld+json)
