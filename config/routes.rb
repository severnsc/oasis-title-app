Rails.application.routes.draw do

  get '/about', to: 'static_pages#about'

  get '/our-team', to: 'static_pages#our_team'

  get '/our-role', to:'static_pages#our_role'

  get '/title-insurance', to:'static_pages#title_insurance'

  get '/real-estate-closings', to:'static_pages#real_estate_closings'

  get '/short-sale-services', to:'static_pages#short_sale_services'

  get '/realtor-services', to:'static_pages#realtor_services'

  get '/lender-services', to:'static_pages#lender_services'

  get 'homeowner-services', to:'static_pages#homeowner_services'

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
