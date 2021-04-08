Rails.application.routes.draw do
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
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# write here weere to go
