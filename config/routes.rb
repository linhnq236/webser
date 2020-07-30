Rails.application.routes.draw do
  resources :reminders
  get "reminder", to: "reminders#index"
  resources :notify_mailer
  get "/send_email", to: "notify_mailer#send_email"
  post "/send_to_email", to: "notify_mailer#send_to_email"
  resources :members
  post "/addmembers/:house_id/:room_id/:information_id", to: "members#create"
  resources :use_services
  post "use_service/:house_id/:room_id/:information_id", to: "use_services#use_service"
  resources :members
  post "/addmembers/:house_id/:room_id/:information_id", to: "members#addmembers"
  get "info_members/:information_id", to: "members#info_members"
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
  get "/payroom/:id/:information_id", to: "rooms#payroom"
  resources :users
  get "/account", to: "users#account"
  namespace "api" do
    resources :houses
    resources :home
    resources :users
    resources :leds
    resources :information
    post "/account", to: "users#account"
    get "getdistrict/:city", to: "houses#getdistrict"
    get "getward/:district", to: "houses#getward"
    get "led_status/:information_id", to: "home#led_status"
    post "app_send/:information_id", to: "leds#app_send_data"
    get "getinfo/:id", to: "information#getinfo"
    post "updateInfo/:id", to: "information#updateInfo"
    get "/getOldCustomer", to: "information#getOldCustomer"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
