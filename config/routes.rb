Rails.application.routes.draw do
  root to: "session#new"
  post "login", to: "session#create", as: :login
  delete "logout", to: "session#destroy", as: :logout

  namespace :user do
    resource :sense, controller: 'sense', only: :show
    resource :profile, controller: 'profile', only: [:show, :update]
    resources :chess_games, only: [:index, :new, :create, :show]
  end
end
