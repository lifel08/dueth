Rails.application.routes.draw do
  root to: 'pages#home'
    devise_for :users

  resources

  get 'instruments/index'
  get 'instruments/show'
  get 'instruments/new'
  get 'instruments/create'
  get 'instruments/update'
  get 'instruments/destro'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/destroy'
  get 'bookings/create'
  get 'bookings/destroy'
  get 'bookings/accept'
  get 'bookings/decline'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# write here weere to go
  root to: 'pages#home'
   devise_for :users

  resources :trips, only: [:new, :create, :edit, :update, :destroy, :show]

  resources :trips do
    resources :bookings, only: :create
  end

  # reviews are part of booking not of trips
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




