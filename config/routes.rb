Rails.application.routes.draw do
  root to: 'pages#home'
    devise_for :users

  resources :instruments do
    get ':title/:location/' => :search, on: :collection, as: :search
    resources :bookings, only: [:new, :create, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
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
