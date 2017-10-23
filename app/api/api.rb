class API < Grape::API
  version 'v1', using: :header, vendor: 'cobalt'
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers
  prefix :api

  resources :videos do
    get do
      Video.all
    end

    params do
      requires :id, type: Integer
    end
    route_param :id do
      get do
        Video.find(params[:id])
      end
    end

    params do
      requires :title, type: String
      requires :file, type: File
    end
    post do
      Video.create!(title: params[:title], file: params[:file][:tempfile])
    end
  end
end
