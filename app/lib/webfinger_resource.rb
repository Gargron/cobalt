# frozen_string_literal: true

class WebfingerResource
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def username
    case resource
    when /\Ahttps?/i
      username_from_url
    when /\@/
      username_from_acct
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def username_from_url
    if account_show_page?
      path_params[:username]
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def account_show_page?
    path_params[:controller] == 'accounts' && path_params[:action] == 'show'
  end

  def path_params
    Rails.application.routes.recognize_path(resource)
  end

  def username_from_acct
    if domain_matches_local?
      local_username
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def split_acct
    resource_without_acct_string.split('@')
  end

  def resource_without_acct_string
    resource.gsub(/\Aacct:/, '')
  end

  def local_username
    split_acct.first
  end

  def local_domain
    split_acct.last
  end

  def domain_matches_local?
    TagManager.owned_domain?(local_domain)
  end
end
