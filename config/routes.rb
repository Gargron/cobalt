require 'sidekiq/web'

Rails.application.routes.draw do
  mount API => '/'
  mount Sidekiq::Web => '/sidekiq'

  get '.well-known/webfinger', to: 'webfinger#show', as: :webfinger

  resources :torrents, only: :show

  get '/@:username', to: 'accounts#show', as: :account
  get '/@:username/outbox', to: 'outboxes#show', as: :outbox
  get '/@:username/activities/:id', to: 'activities#show', as: :activity
  get '/@:username/videos/:id', to: 'videos#show', as: :video

  post '/@:username/inbox', to: 'inboxes#create', as: :inbox
  post '/inbox', to: 'inboxes#create', as: :shared_inbox

  get '/*any', to: 'home#index', as: :web

  root 'home#index'
end
