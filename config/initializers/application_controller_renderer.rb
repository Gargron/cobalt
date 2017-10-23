# Be sure to restart your server when you modify this file.

ActiveSupport::Reloader.to_prepare do
  ApplicationController.renderer.defaults.merge!(
    http_host: "localhost:#{ENV['PORT']}",
    https: false
  )
end
