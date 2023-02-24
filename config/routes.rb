Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "instruments", to: "instruments#index"
  get "bookings", to: "bookings#index", as: :bookings
  get "instruments/:id", to: "instruments#show", as: :instrument
  get "instruments/new", to: "instruments#new", as: :new_instrument
  get "/instruments/:id/rent/new", to: "bookings#new", as: :new_booking
  get "/instruments/:id/edit", to: "instruments#edit", as: :edit_instrument
  post "/instruments/:id/rent/new", to: "bookings#create"
  post "instruments", to: "instruments#create"
  patch "instruments/:id", to: "instruments#update"
  delete "instruments/:id", to: "instruments#destroy", as: :destroy_instrument
  delete "/booking/:id/cancel", to: "bookings#destroy", as: :destroy_booking
end
