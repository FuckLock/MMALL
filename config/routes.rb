# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  resources :users
  resources :sessions
  get 'passreset', to: "sessions#passreset", as: :passreset
  get 'register/success', to: "users#register", as: :register_success

  resources :products
  resources :shopping_carts
  resources :categories

  resources :addresses do
    member do
      put 'set_default_address'
    end
  end

  resources :orders
  resources :payments do
    collection do
      get 'generate_pay'
    end
  end

  namespace :admin do
    root 'home#index'
    get '/products/ajax_new', to: "products#ajax_new"
    post '/product_images/upload_images', to: 'product_images#upload_images'
    # root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images
    end
  end
end
