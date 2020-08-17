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
        ["STATUS", "TURNON", "TURNOFF"].each do |p|
          string = "#{remove_space_upcase_string(house.name)}/Phong#{room.name}/LED_STATUS#{k}/#{p}"
          array_setup.push(string);
        end
      end
      render json: {data: array_setup}
    end
  end
end
