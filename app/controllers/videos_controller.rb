class VideosController < ApplicationController
  before_action :set_video

  def show
    respond_to do |format|
      format.json do
        render json: @video,
               serializer: ActivityPub::VideoSerializer,
               adapter: ActivityPubAdapter,
               content_type: 'application/activity+json'
      end
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
