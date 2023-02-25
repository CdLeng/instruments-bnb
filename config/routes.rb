Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  resources :instruments, only: [:index, :show] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:destroy]



  get "/booking/all", to: "bookings#show", as: :my_bookings


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "instruments", to: "instruments#index"
  # get "instruments/:id", to: "instruments#show", as: :instrument
  # get "/instruments/:id/bookings/new", to: "bookings#new", as: :bookings
  # post "/instruments/:id/bookings/new", to: "bookings#create"

  # delete "/booking/:id", to: "bookings#destroy"
  # #get "/instruments/:id/rent/show", to: "bookings#show", as: :my_bookings


end
