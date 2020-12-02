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
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      information_id = params[:information_id]
      valueselect = params[:valueselect]
      room = Room.find_by_information_id(information_id)
      if valueselect == "1"
        ['led_status1','led_status3','led_status6','led_status7'].each do |p|
          firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(room.house.name)}/Phong#{room.name}/#{p}/status": 'on'})
        end
      elsif valueselect == "2"
        ['led_status1','led_status3','led_status6','led_status7'].each do |p|
          firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(room.house.name)}/Phong#{room.name}/#{p}/status": 'off'})
        end
      elsif valueselect == "3"
        ['led_status2','led_status8'].each do |p|
          firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(room.house.name)}/Phong#{room.name}/#{p}/status": 'on'})
        end
      elsif valueselect == "4"
        ['led_status2','led_status8'].each do |p|
          firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(room.house.name)}/Phong#{room.name}/#{p}/status": 'off'})
        end
      end
      render json: {status: 200}
    end
  end
end
