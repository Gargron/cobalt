class TagManager
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
  end
end
