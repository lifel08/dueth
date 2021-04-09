Rails.application.routes.draw do
  root to: 'pages#home'
    devise_for :users

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :instruments, only: [:show, :new, :edit, :update, :destroy]

# user practiser who books an instrument
  resources :instruments do
    resources :bookings, only: [:new, :create, :update, :destroy]
  end

  resources :bookings, only: :destroy do
    member do
      patch :accept
      patch :decline
    end
    resources :reviews, only: [:create, :edit, :destroy]
  end
  resources :reviews, only: :destroy
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
