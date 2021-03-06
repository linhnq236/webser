Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # scope "(:locale)", locale: /en|vn/ do
    resources :regulations
    resources :apps
    resources :reports
    resources :paytherents
    # mount ActionCable.server, at: '/cable'
    resources :statisticals
    resources :reminders
    get "reminder", to: "reminders#index"
    resources :notify_mailer
    get "/send_email", to: "notify_mailer#send_email"
    post "/send_to_email", to: "notify_mailer#send_to_email"
    get "/send_mail_cost_room/:house_id/:room_id/:information_id", to: "notify_mailer#send_mail_cost_room"
    get "/getMoneyPerMonth", to: "notify_mailer#getMoneyPerMonth"
    resources :members
    post "/addmembers/:house_id/:room_id/:information_id", to: "members#create"
    get "/show_detail_members/:information_id", to: "members#show_detail_members"
    resources :use_services
    post "use_service/:house_id/:room_id/:information_id", to: "use_services#use_service"
    get "/show_detail_useservice/:information_id", to: "use_services#show_detail_useservice"
    resources :members
    post "/addmembers/:house_id/:room_id/:information_id", to: "members#addmembers"
    get "info_members/:information_id", to: "members#info_members"
    resources :services
    resources :information
    post "/new_information_customer/:house_id/:room_id", to: "information#new_information_customer"
    put "/update_information_customer/:house_id/:room_id/:information_id", to: "information#update_information_customer"
    resources :houses
    get "/deletehouse/:id", to: "houses#deletehouse"
    resources :homes
    root "homes#index"
    get "led_status", to: "homes#led_status"
    post "updatestatus", to: "homes#updatestatus"
    post "settime", to: "homes#settime"
    post "/disable_endable", to: "homes#disable_endable"
    get "login", to: "homes#login"
    get "gettemperature", to: "homes#gettemperature"
    post "/voice", to: "homes#voice"
    get "/callvideo", to: "homes#callvideo"
    resources :rooms
    get "room_fast", to: "rooms#room_fast"
    post "/roomfast", to: "rooms#roomfast"
    get "/addcustomer/:house_id/:room_id", to: "rooms#addcustomer"
    get "/listcustomer/:house_id/:room_id/:information_id", to: "rooms#listcustomer"
    post "/indexservice/:house_id/:room_id/:information_id", to: "rooms#indexservice"
    post "/information_service", to: "rooms#information_service"
    get "/payroom/:id/:information_id", to: "rooms#payroom"
    get "/cancel_infor/:information_id", to: "rooms#cancel_infor"
    resources :users
    get "/account", to: "users#account"
    post "/createaccount", to: "users#createaccount"
  # end
  namespace "api" do
    resources :houses
    get "getdistrict/:city", to: "houses#getdistrict"
    get "getward/:district", to: "houses#getward"
    resources :home
    get "led_status/:information_id", to: "home#led_status"
    post "/group_leds", to: 'home#group_leds'
    resources :users
    post "/account", to: "users#account"
    post "/active_acc/:id", to: "users#active_acc"
    resources :leds
    post "app_send/:information_id", to: "leds#app_send_data"
    get "/setup/:room_id", to: "leds#setup"
    post "/groupleds/:information_id", to: "leds#groupleds"
    resources :information
    post "updateInfo/:id", to: "information#updateInfo"
    get "/getOldCustomer", to: "information#getOldCustomer"
    get "getinfo/:id", to: "information#getinfo"
    post "/changed_email/:information_id", to: "information#changed_email"
    resources :reminders
    get "/getReminder", to: "reminders#getReminder"
    put "/check_mark/:id", to: "reminders#check_mark"
    resources :paytherents
    put "/updatePaytherent/:information_id", to: "paytherents#update"
    get "/getPaytheRent/:information_id", to: "paytherents#getPaytheRent"
    post "/update_money", to: "paytherents#update_money"
    post "/export", to:"paytherents#export"
    resources :use_services
    get "/getUseServices/:information_id", to: "use_services#getUseServices"
    resources :reports
    get "/showpopup/:id", to: "reports#showpopup"
    post "/deleteId/:id", to: "reports#deleteId"
    post "/status_feedback/:report_id/:status", to: "reports#status_feedback"
    resources :supports
    resources :services
    resources :apps
    get "/appSlider", to: "apps#appSlider"
    get "/delete_slider", to: "apps#delete_slider"
    get "/edit_slider/:id", to: "apps#edit_slider"
    patch "/update/:id", to: "apps#update"
    resources :regulations
    get "/getRegulations/:information_id", to: "regulations#getRegulations"
    resources :members
    get "info_members/:information_id", to: "members#info_members"

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
