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
      # ENABLE ,     'DISABLE', 'DOOR OPEN', 'DOOR CLOSE', 'LIGTH ON', 'LIGTH OFF', 'FAN ON', 'FAN OFF', 'POWER SOCKET ON', 'POWER SOCKET OFF']
          # 0           1             2             3           4           5         6           7                   8             9
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      house_id = params[:group_house_id]
      house = House.find(house_id)
      room_name = params[:room_name]
      equiment_status = params[:equiment_status]
      if room_name != 'all'
        if equiment_status == "0"
          ['led_status0','led_status1','led_status2','led_status3','led_status5','led_status6','led_status7','led_status8'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/active": 'enable'})
          end
        elsif equiment_status == '1'
          ['led_status0','led_status1','led_status2','led_status3','led_status5','led_status6','led_status7','led_status8'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/active": 'disable'})
          end
        elsif equiment_status == '2'
          ['led_status1','led_status3','led_status6','led_status7'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/status": 'on'})
          end
        elsif equiment_status == '3'
          ['led_status1','led_status3','led_status6','led_status7'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/status": 'off'})
          end
        elsif equiment_status == '4'
          ['led_status2','led_status8'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/status": 'on'})
          end
        elsif equiment_status == '5'
          ['led_status2', 'led_status8'].each do |p|
            firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/#{room_name}/#{p}/status": 'off'})
          end
        end
      else
        @rooms = Room.where(house_id: house_id)
        @rooms.each do |f|
          if equiment_status == "0"
            ['led_status0','led_status1','led_status2','led_status3','led_status5','led_status6','led_status7','led_status8'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/active": 'enable'})
            end
          elsif equiment_status == '1'
            ['led_status0','led_status1','led_status2','led_status3','led_status5','led_status6','led_status7','led_status8'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/active": 'disable'})
            end
          elsif equiment_status == '2'
            ['led_status1','led_status3','led_status6','led_status7'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/status": 'on'})
            end
          elsif equiment_status == '3'
            ['led_status1','led_status3','led_status6','led_status7'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/status": 'off'})
            end
          elsif equiment_status == '4'
            ['led_status2','led_status8'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/status": 'on'})
            end
          elsif equiment_status == '5'
            ['led_status2', 'led_status8'].each do |p|
              firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(f.house.name)}/Phong#{f.name}/#{p}/status": 'off'})
            end
          end
        end
      end
      render json: {status: 200}
    end
  end
end
