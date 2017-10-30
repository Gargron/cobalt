class TagManager
  CONTEXT = 'https://www.w3.org/ns/activitystreams'

  class << self
    include RoutingHelper

    def uri_for(record)
      case record.class.to_s
      when 'Account'
        account_url(record)
      when 'Video'
        video_url(record.account, record)
      end
    end

    def owned_domain?(domain)
      local_domain?(domain) || web_domain?(domain)
    end

    def web_domain?(domain)
      domain.nil? || domain.gsub(/[\/]/, '').casecmp(Rails.configuration.x.web_domain).zero?
    end

    def local_domain?(domain)
      domain.nil? || domain.gsub(/[\/]/, '').casecmp(Rails.configuration.x.local_domain).zero?
    end

    def local_uri?(uri)
      uri  = Addressable::URI.parse(uri)
      host = uri.normalized_host
      host = "#{host}:#{uri.port}" if uri.port

      !host.nil? && owned_domain?(host)
    end

    def uri_to_resource(uri, klass)
      if local_uri?(uri)
        klass.find(uri_to_local_id(uri))
      else
        klass.find_by(uri: uri.split('#').first)
      end
    end

    private

    def uri_to_local_id(uri, param = :id)
      path_params = Rails.application.routes.recognize_path(uri)
      path_params[param]
    end
  end
end
