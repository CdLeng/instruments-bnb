Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "instruments", to: "instruments#index"
  get "instruments/:id", to: "instruments#show", as: :instrument
  get "/instruments/:id/rent/new", to: "bookings#new", as: :bookings
  post "/instruments/:id/rent/new", to: "bookings#create"
  delete "/booking/:id/cancel", to: "bookings#destroy", as: :destroy
  get "/instruments/:id/rent/show", to: "bookings#show", as: :my_bookings
  get "/booking/all", to: "bookings#show", as: :my_bookings
  get "/instruments/:id/reviews/new", to: "reviews#new", as: :new_review
  resources :instruments, except: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
end
