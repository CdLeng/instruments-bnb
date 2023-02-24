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
  get "/booking/all", to: "bookings#show", as: :my_bookings

  get "/category/all", to: "instrument_categories#index", as: :categories
  get "category/:id", to: "instrument_categories#show", as: :category
  # get "/instruments/:id/reviews/new", to: "reviews#new", as: :new_review
  resources :instruments, except: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
end
