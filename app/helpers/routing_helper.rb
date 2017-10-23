# frozen_string_literal: true

module RoutingHelper
  extend ActiveSupport::Concern

  include Rails.application.routes.url_helpers

  included do
    def default_url_options
      { host: "localhost:#{ENV['PORT']}" }
    end
  end

  def upload_url(path)
    URI.join(root_url, path).to_s
  end
end
