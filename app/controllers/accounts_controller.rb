class AccountsController < ApplicationController
  before_action :set_account

  def show
    respond_to do |format|
      format.json do
        render json: @account,
               serializer: ActivityPub::ActorSerializer,
               adapter: ActivityPubAdapter,
               content_type: 'application/activity+json'
      end
    end
  end

  private

  def set_account
    @account = Account.find_by!(username: params[:username])
  end
end
