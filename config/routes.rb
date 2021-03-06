Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  get '/search', to: 'pages#search', as: :home_search
  get '/passer-premium', to: 'pages#premium'
  get '/subscribe-premium', to: 'pages#subscribe_premium'
  resources :premium_subscriptions, only: [:index, :show]

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  resources :flats do
    resources :chatrooms, only: :create
  end

  resources :preferences, only: [:update, :edit]

  resources :profiles, only: :show do
    resources :reviews, only: [:index, :create, :new]
    get '/my-profile', to: 'profiles#my_profile', as: :my_profile
  end

  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
  end
  resources :autocompletes
  get '/autocompletes-new', to: 'autocompletes#new'

end
