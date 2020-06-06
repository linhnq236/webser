Rails.application.routes.draw do
  devise_for :users
  resources :home
  root "home#index"
  get "led_status", to: "home#led_status"
  post "updatestatus", to: "home#updatestatus"
  post "settime", to: "home#settime"
  get "gettemperature", to: "home#gettemperature"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
