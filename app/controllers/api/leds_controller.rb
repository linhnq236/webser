module Api
  class LedsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    require "firebase_connect"

    def app_send_data
      information_id = params[:information_id]
      name = params[:name]
      column = params[:column]
      status = params[:status]
      room_name = getRoom(information_id)
      house_name = getHouseRoom(information_id)

      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)

      response = firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{name}/#{column}": status})

      render json: {status: 200}
    end

    def setup
      array_setup = []
      string = ''
      room = Room.find(params[:room_id])
      house = House.find(room.house_id)
      [0,1,2,3,5,6,7,8].each do |k|
        ["status", "turnon", "turnoff"].each do |p|
          string = "#{remove_space_upcase_string(house.name)}/Phong#{room.name}/led_status#{k}/#{p}"
          array_setup.push(string);
        end
      end
      render json: {data: array_setup}
    end

    def groupleds
      information_id = params[:information_id]
      valueselect = params[:valueselect]
      room = Room.find_by_information_id(information_id)
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      responses = firebase.get(FIREBASE_URL).body
      house_name = remove_space_upcase_string(room.house.name)
      room_name = "Phong#{room.name}"
      leds = responses[house_name][room_name]
      leds.each do |res|
        if res[1]['kind'] == "1" && valueselect == "2" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "1" && valueselect == "3" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        elsif res[1]['kind'] == "2" && valueselect == "4" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "2" && valueselect == "5" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        elsif res[1]['kind'] == "3" && valueselect == "6" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "On"})
        elsif res[1]['kind'] == "3" && valueselect == "7" && res[1]['active'] == 'Enable'
          firebase.update(FIREBASE_URL, {"#{house_name}/#{room_name}/#{res[0]}/status": "Off"})
        end
      end
      render json: {status: 200}
    end
  end
end
