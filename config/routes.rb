Rails.application.routes.draw do
    root to: 'pages#home'
    get 'profile', to: 'pages#profile'
    devise_for :users

    resources :instruments do
      member do
        put :pause
        put :activate
      end
      resources :bookings, only: [:new, :create, :update, :destroy]
    end
    get '/instruments/:title/:location/', to: 'instruments#search', as: :search_instruments

    resources :users do
      resources :reviews, only: [:create, :edit, :destroy]
    end

    resources :bookings, only: :destroy do
      member do
        patch :accept
        patch :decline
      end
      resources :reviews, only: [:create, :edit, :destroy]
    end
    resources :reviews, only: :destroy
  end
