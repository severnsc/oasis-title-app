Rails.application.routes.draw do

  get 'agents/show'

  resources :title_orders

  resources :brokerages, only: [:show]
  
  resources :agents, only: [:show]

  resources :users

  resources :account_activation, only: [:edit]

  get '/login', to: "sessions#new"

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'
end
