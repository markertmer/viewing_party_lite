Rails.application.routes.draw do
  get "/", to: "welcome#index"

  # resources :user, only: [:show]
  get "/register", to: "users#new"
  post "/users", to: "users#create"
  # get "/users/:id", to: "users#show"
  get "/dashboard", to: "users#show"
  # get "/users/:id/discover", to: "users#discover"
  get "/discover", to: "users#discover"
  # get "/users/:id/movies", to: "users#movies"
  get "/movies", to: "users#movies"
  # post "/users/:id/movies", to: "users#movies"
  post "/movies", to: "users#movies"
  # get "/users/:id/movies/:movie_id", to: "users#movie_show"
  get "/movies/:movie_id", to: "users#movie_show"


  # get "login", to: "users#login_form"
  # post "login", to: "users#login_user"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

end
