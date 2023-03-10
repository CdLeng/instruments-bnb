Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :instruments do
    resources :bookings, only: [:new, :create]
    resources :reviews
  end
  resources :bookings, only: [:destroy]

  get "/booking/all", to: "bookings#all", as: :my_bookings
  get "my-instruments", to: "instruments#my_instruments", as: :my_instruments
  get "/category/all", to: "instrument_categories#index", as: :categories
  get "category/:id", to: "instrument_categories#show", as: :category
  get "booking/:id/edit", to: "bookings#edit", as: :edit_booking
  patch "bookings/:id", to: "bookings#update"


  # get "instruments", to: "instruments#index"
  # get "bookings", to: "bookings#index", as: :bookings
  # get "instruments/:id", to: "instruments#show", as: :instrument
  # get "instruments/new", to: "instruments#new", as: :new_instrument
  # get "/instruments/:id/rent/new", to: "bookings#new", as: :new_booking
  # get "/instruments/:id/edit", to: "instruments#edit", as: :edit_instrument
  # post "/instruments/:id/rent/new", to: "bookings#create"
  # post "instruments", to: "instruments#create"
  # patch "instruments/:id", to: "instruments#update"
  # delete "instruments/:id", to: "instruments#destroy", as: :destroy_instrument
  # delete "/booking/:id/cancel", to: "bookings#destroy", as: :destroy_booking
  # get "/booking/all", to: "bookings#show", as: :my_bookings
  # get "/instruments/:id/reviews/new", to: "reviews#new", as: :new_review
  # resources :instruments, except: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
end
