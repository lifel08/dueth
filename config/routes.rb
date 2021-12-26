Rails.application.routes.draw do
  root to: 'pages#home'
  get 'profile', to: 'pages#profile'
  get 'public_profile/:id', to: 'pages#public_profile', as: :public_profile
  devise_for :users

  resources :instruments do
    member do
      put :pause
      put :activate
      post :book
    end
    resources :reviews
    resources :bookings
  end
  get '/instruments/:title/:city/', to: 'instruments#search', as: :search_instruments

  resources :users do
  end

  resources :bookings, only: [:destroy, :index] do
    member do
      patch :accept
      patch :decline
      patch :cancel
    end
  end
end
