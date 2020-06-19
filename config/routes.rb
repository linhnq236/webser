Rails.application.routes.draw do
  resources :services
  resources :information
  post "/new_information_customer/:house_id/:room_id", to: "information#new_information_customer"
  put "/update_information_customer/:house_id/:room_id/:information_id", to: "information#update_information_customer"
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
  resources :rooms
  get "room_fast", to: "rooms#room_fast"
  post "/roomfast", to: "rooms#roomfast"
  get "/addcustomer/:house_id/:room_id", to: "rooms#addcustomer"
  get "/listcustomer/:house_id/:room_id/:information_id", to: "rooms#listcustomer"
  post "/information_service", to: "rooms#information_service"
  namespace "api" do
    resources :houses
    resources :home
    get "getdistrict/:city", to: "houses#getdistrict"
    get "getward/:district", to: "houses#getward"
    get "led_status", to: "home#led_status"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
