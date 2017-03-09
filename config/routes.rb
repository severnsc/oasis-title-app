Rails.application.routes.draw do

  get 'agents/show'

  resources :title_orders

  resources :brokerages, only: [:show]
  
  resources :agents, only: [:show]

  resources :users

  resources :account_activation, only: [:edit]

  get '/login', to: "sessions#new"

  get '/title-order', to: 'static_pages#title_order', as: 'number_of_buyers'

  get '/request-quote', to: 'static_pages#request_quote'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'
end
