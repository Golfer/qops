require 'versionist/routing_params'

Rails.application.routes.draw do
  ####################
  ###   Root Level ###
  ####################
  root to: 'dashboards#index'

  ###########################
  ###   ADMIN Resources   ###
  ###########################
  namespace :admin do
    root to: 'dashboards#index'
    resources :authors
    resources :quotations
    resources :categories do
      match :quotations, on: :member, via: %i(get post)
      get :published
    end
    resources :tags
  end

  ### API ###
  namespace :api, defaults: { format: :json } do
    api_version(api_version_params(1, defaults: { format: :json }, default: true)) do
      resources :quotations, only: %i(index create)
    end
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable
end
