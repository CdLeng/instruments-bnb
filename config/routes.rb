Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "instruments", to: "instruments#index"
  get "instruments/:id", to: "instruments#show", as: :instrument
  get "/instruments/:id/rent/new", to: "bookings#new", as: :bookings
  post "/instruments/:id/rent/new", to: "bookings#create"
  delete "/booking/:id/cancel", to: "bookings#destroy", as: :destroy
end
