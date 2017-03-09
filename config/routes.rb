Rails.application.routes.draw do

  get 'agents/show'

  resources :title_orders

  resources :brokerages, only: [:show]
  
  resources :agents, only: [:show]

  resources :users

  resources :account_activation, only: [:edit]
end
