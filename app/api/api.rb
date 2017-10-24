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
      Video.published
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
      end

      put do
        video = current_account.videos.find(params[:id])
        video.update!(declared(params, include_missing: false))
        video
      end
    end

    params do
      requires :file, type: File
    end

    post do
      Video.create!(file: params[:file][:tempfile],
                    account: current_account)
    end
  end
end
