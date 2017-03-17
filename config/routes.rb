Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  namespace :blog do
    resources :posts
  end

  get '/about', to: 'static_pages#about'

  get '/our-team', to: 'static_pages#our_team'

  get '/our-role', to:'static_pages#our_role'

  get '/title-insurance', to:'static_pages#title_insurance'

  get '/real-estate-closings', to:'static_pages#real_estate_closings'

  get '/short-sale-services', to:'static_pages#short_sale_services'

  get '/realtor-services', to:'static_pages#realtor_services'

  get '/lender-services', to:'static_pages#lender_services'

  get '/homeowner-services', to:'static_pages#homeowner_services'

  get '/closing-costs', to:'static_pages#closing_costs'

  get '/glossary', to: 'static_pages#glossary'

  get '/title-faq', to:'static_pages#title_faq'

  resources :password_reset, only: [:new, :create, :edit, :update]

  resources :title_orders

  resources :brokerages, only: [:show]
  
  resources :agents, only: [:show]

  resources :users

  get 'users/:id/admin', to: 'users#admin', as: 'admin'

  post 'users/:id/admin', to: 'users#admin_invite', as: 'admin_invite'

  resources :admin_status, only: [:edit], to: 'users#edit_admin_status'

  resources :account_activation, only: [:edit]

  get '/login', to: "sessions#new"

  get '/title-order', to: 'static_pages#title_order', as: 'number_of_buyers'

  get '/request-quote', to: 'static_pages#request_quote'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'
end
