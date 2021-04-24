Rails.application.routes.draw do
    root to: 'pages#home'
    get 'profile', to: 'pages#profile'
    devise_for :users

    resources :instruments do
      member do
        put :pause
        put :activate
      end
      get ':title/:location/' => :search, on: :collection, as: :search
      resources :bookings, only: [:new, :create, :update, :destroy]
    end

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
