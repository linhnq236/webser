module Api
  class HomeController < ApplicationController
    include ApplicationHelper
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    # FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
    # FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
    require "firebase_connect"

    def led_status
      information_id = params[:information_id]
      room = Room.find_by_information_id(information_id)
      house = House.find(room.house_id)
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      leds = firebase.get(FIREBASE_URL).body
      render json: {leds: leds["#{remove_space_upcase_string(house.name)}"]["Phong#{room.name}"]}
    end

  end
end
