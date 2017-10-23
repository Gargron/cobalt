require 'sidekiq/web'

Rails.application.routes.draw do
  mount API => '/'
  mount Sidekiq::Web => '/sidekiq'

  resources :torrents, only: :show
  get '/*any', to: 'home#index', as: :web

  root 'home#index'
end
