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

    def group_leds
      # equiment_status
      # ENABLE ,     'DISABLE', 'LIGTH ON', 'LIGTH OFF', 'FAN ON', 'FAN OFF', 'POWER SOCKET ON', 'POWER SOCKET OFF']
          # 0           1             2             3           4           5         6           7
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      house_id = params[:group_house_id]
      house = House.find(house_id)
      room_name = params[:room_name]
      equiment_status = params[:equiment_status]
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      responses = firebase.get(FIREBASE_URL).body
      house_name = remove_space_upcase_string(house.name)
      leds = responses[house_name][room_name]
      leds.each do |res|
        if equiment_status == "0" && res[1]['active'] == 'Disable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/active": "Enable"})
        elsif equiment_status == "1" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/active": "Disable"})
        elsif res[1]['kind'] == "1" && equiment_status == "2" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "1" && equiment_status == "3" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        elsif res[1]['kind'] == "2" && equiment_status == "4" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "2" && equiment_status == "5" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        elsif res[1]['kind'] == "3" && equiment_status == "6" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "3" && equiment_status == "7" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        end
      end
      render json: {status: 200}
    end
  end
end
