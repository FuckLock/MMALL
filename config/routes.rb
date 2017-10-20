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
  post '/categories/up', to: "categories#up_product"
  post '/categories/down/', to: "categories#down_product"
  post '/categories/show', to: "categories#show"
  post 'shopping_carts/update_amount', to: "shopping_carts#update_amount"
  post 'shopping_carts/select_value', to: "shopping_carts#select_value"
  post 'shopping_carts/select_checked', to: "shopping_carts#select_checked"
  
  resources :addresses do
    member do
      put 'set_default_address'
    end
  end
  post 'addresses/update-params', to: "addresses#update_params"
  post 'address/edit', to: "addresses#edit"
  post 'address/new', to: "addresses#edit"
  get '/switchoff', to: "orders#new"

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
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images
    end
  end
end
