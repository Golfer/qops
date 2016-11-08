require 'versionist/routing_params'

Rails.application.routes.draw do
  get 'author/index'

  get 'author/show'

  mount ActionCable.server => '/cable'

  if Rails.env.production? || Rails.env.development?
    get '404', to: 'application#page_not_found'
    get '422', to: 'application#server_error'
    get '500', to: 'application#server_error'
  end

  devise_for :users,
              controllers: {
                #omniauth_callbacks: 'users/omniauth_callbacks',
                sessions:      'users/sessions',
                registrations: 'users/registrations',
                passwords:     'users/passwords'
              }
  resources :users, except: %i(index show create new destroy) do
    member do
      get :message
      get :dashboard
      get :profile
    end
  end

  ####################
  ###   Root Level ###
  ####################
  root controller: :dashboards, action: :index, as: :root
  match :latest, controller: :dashboards, action: :latest, via: %i(get)
  resources :authors, only: %i(index show)
  resources :categories, only: %i(index)
  resources :tags, only: %i(index)

  ###########################
  ###   ADMIN Resources   ###
  ###########################
  namespace :admin do
    root controller: :dashboards, action: :index, as: :root
    resources :pages
    resources :settings
    resources :authors do
      get :publicate, controller: :quotations, action: :author_quotations_publicate
      get :unpublicate, controller: :quotations, action: :author_quotations_unpublicate
    end
    resources :quotations do
      match :publicated, on: :member, via: %i(get)
    end
    resources :categories do
      match :quotations, on: :member, via: %i(get post)
      get :published
    end
    resources :tags
  end

  ### API ###
  namespace :api, defaults: { format: :json } do
    api_version(api_version_params(1, defaults: { format: :json }, default: true)) do
      post :multy_uploader, to: 'base#multy_uploader'
      resources :categories, only: %i(index create)
      resources :tags, only: %i(index create)
      resources :quotations, only: %i(index create)
      resources :authors, only: %i(index create)
    end
  end
end
