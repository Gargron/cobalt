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
  end
end
