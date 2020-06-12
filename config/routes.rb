Rails.application.routes.draw do
  resources :rooms
  resources :houses
  get "/deletehouse/:id", to: "houses#deletehouse"
  devise_for :users
  resources :home
  root "home#index"
  get "led_status", to: "home#led_status"
  post "updatestatus", to: "home#updatestatus"
  post "settime", to: "home#settime"
  get "login", to: "home#login"
  get "gettemperature", to: "home#gettemperature"
  get "room_fast", to: "rooms#room_fast"
  post "/roomfast", to: "rooms#roomfast"
  namespace "api" do
    resources :houses
    get "getdistrict/:city", to: "houses#getdistrict"
    get "getward/:district", to: "houses#getward"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
