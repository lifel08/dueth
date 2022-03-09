Rails.application.routes.draw do
  root to: 'pages#home'
  get 'profile', to: 'pages#profile'
  get 'public_profile/:id', to: 'pages#public_profile', as: :public_profile
  devise_for :users

  resources :instruments do
    put :favorite, on: :member
    member do
      put :pause
      put :activate
      post :book
    end
    collection do
      get :favorite_list
    end
    resources :bookings, only: [:new, :create, :update, :destroy]
    resources :reviews
    resources :instrument_bookings do
      member do
        patch :accept
        patch :decline
        patch :cancel
      end
    end
    resources :instrument_disponbilities
  end
  get '/instruments/:title/:city/', to: 'instruments#search', as: :search_instruments

  resources :users do
    resources :client_bookings, only: [:index]
  end
  resources :bookings, only: [:destroy, :index] do
    member do
      patch :accept
      patch :decline
      patch :cancel
    end
  end
end
