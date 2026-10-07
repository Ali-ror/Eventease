Rails.application.routes.draw do
  get "/.well-known/appspecific/com.chrome.devtools.json", to: "well_known#chrome_devtools"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }

  devise_scope :user do
    get "login", to: "users/sessions#new", as: :login
    post "login", to: "users/sessions#create"
    delete "logout", to: "users/sessions#destroy", as: :logout

    get "signup", to: "users/registrations#new", as: :signup
    post "signup", to: "users/registrations#create"

    get "forgot-password", to: "users/passwords#new", as: :forgot_password
    post "forgot-password", to: "users/passwords#create"

    get "reset-password", to: "users/passwords#edit", as: :reset_password
    patch "reset-password", to: "users/passwords#update"
    put "reset-password", to: "users/passwords#update"
  end

  patch "session/view_mode", to: "session/view_modes#update", as: :session_view_mode

  get "dashboard", to: "dashboard#show", as: :dashboard
  get "notifications", to: "notifications#index", as: :notifications

  namespace :admin do
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy", as: :logout
    get "dashboard", to: "dashboard#show", as: :dashboard
  end

  root "pages#landing"
  get "landing", to: "pages#landing"
end
