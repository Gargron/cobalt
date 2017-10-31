class API < Grape::API
  version 'v1', using: :header, vendor: 'cobalt'
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  prefix :api

  helpers do
    def current_account
      @current_account ||= Account.first
    end
  end

  resources :videos do
    get do
      current_account.videos.published
    end

    params do
      requires :id, type: Integer
    end

    route_param :id do
      get do
        Video.find(params[:id])
      end

      params do
        optional :title, type: String
        optional :published, type: Boolean
        optional :description, type: String
        optional :thumbnail, type: File
      end

      put do
        video     = current_account.videos.find(params[:id])
        published = video.published

        video.update!(declared(params, include_missing: false))

        if !published && video.published
          ActivityManager.create(:create, video)
        elsif published && !video.published
          ActivityManager.create(:delete, video)
        elsif video.published
          ActivityManager.create(:update, video)
        end

        video
      end

      delete do
        video = current_account.videos.find(params[:id])
        video.destroy!
        video
      end
    end

    params do
      requires :file, type: File
    end

    post do
      Video.create!(declared(params).merge(account: current_account))
    end
  end
end
