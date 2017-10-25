# frozen_string_literal: true

port     = ENV.fetch('PORT') { 3000 }
host     = ENV.fetch('LOCAL_DOMAIN') { "localhost:#{port}" }
web_host = ENV.fetch('WEB_DOMAIN') { host }
https    = ENV['LOCAL_HTTPS'] == 'true'

alternate_domains = ENV.fetch('ALTERNATE_DOMAINS') { '' }

Rails.application.configure do
  config.x.local_domain = host
  config.x.web_domain   = web_host
  config.x.use_https    = https

  config.action_mailer.default_url_options = { host: web_host, protocol: https ? 'https://' : 'http://', trailing_slash: false }
end
