require 'sidekiq/web'

Rails.application.routes.draw do
  mount API => '/'
  mount Sidekiq::Web => '/sidekiq'

  resources :torrents, only: :show

  get '/@:username', to: 'accounts#show', as: :account
  get '/@:username/:id', to: 'videos#show', as: :video
  get '/*any', to: 'home#index', as: :web

  root 'home#index'
end
