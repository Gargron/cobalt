class ActivitiesController < ApplicationController
  before_action :set_payload

  def show
    respond_to do |format|
      format.json do
        render json: @payload.payload, content_type: 'application/activity+json'
      end
    end
  end

  private

  def set_payload
    @payload = Payload.where(local: true).find(request.url)
  end
end
