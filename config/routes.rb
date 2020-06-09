Rails.application.routes.draw do
  resources :rooms
  resources :houses
  devise_for :users
  resources :home
  root "home#index"
  get "led_status", to: "home#led_status"
  post "updatestatus", to: "home#updatestatus"
  post "settime", to: "home#settime"
  get "login", to: "home#login"
  get "gettemperature", to: "home#gettemperature"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
