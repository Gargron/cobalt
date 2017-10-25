class WebfingerController < ApplicationController
  before_action :set_account

  def show
    respond_to do |format|
      format.json do
        render json: @account,
               serializer: WebfingerSerializer,
               content_type: 'application/jrd+json'
      end
    end
  end

  private

  def set_account
    @account = Account.find_by!(username: username_from_resource)
  end

  def username_from_resource
    WebfingerResource.new(params[:resource]).username
  end
end
