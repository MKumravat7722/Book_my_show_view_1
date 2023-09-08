Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only:[:index ,:create, :update, :destroy, :show]
  resources :theaters
  resources :screens
  resources :movies
  resources :shows
  resources :tickets
  post 'users/login', to: 'application#login'
  resources :movies
  get "/search_movie", to: "movies#search_movie"
  get "/search_tickets",to: "tickets#search_tickets"
  # Defines the root path route ("/")
  root "users#signup"
  get "/login", to: "users#login"
end
