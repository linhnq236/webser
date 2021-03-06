class HomesController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token
  # FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  # FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  require "firebase_connect"

  def index
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    response = firebase.get(FIREBASE_URL).body
    if current_user.admin == 1
      @houses = House.where(id: current_user.house_id)
    else
      @houses = $houses
    end
    if params['house_id'].present?
      house= House.find(params[:house_id])
      house_name = remove_space_upcase_string(house.name)
      gon.chose_rooms = response[house_name]
    end
  end

  def updatestatus
    status = params[:status]
    active = params[:active]
    area = params[:area]
    column = params[:column]
    subcolumn = params[:subcolumn]
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    if(subcolumn == 'active')
      response = firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}/#{subcolumn}": active})
                 firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}/turnon": '0000-00-00 00:00'})
                 firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}/turnoff": '0000-00-00 00:00'})
    else
      response = firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}/#{subcolumn}": active})
    end
    ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: response.body
    head :no_content
  end
  def settime
    status = params[:status]
    area = params[:area]
    column = params[:column]
    subcolumn = params[:subcolumn]
    settime = params[:settime]

    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    response = firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}/#{subcolumn}": settime})
    ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: response.body
    head :no_content
  end

  def voice
    name = params[:name]
    house_id = name.slice(0)
    room_id = name.slice(1,name.size-3)
    chip = name.slice(name.size-2)
    status = name.slice(name.size-1)
    set_status = ''
    if status == '1'
      set_status = 'On'
    else
      set_status = 'Off'
    end
    house = House.find(house_id)
    room = Room.find_by_name(room_id)


    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    leds = firebase.get(FIREBASE_URL).body
    checkled_disable = leds[remove_space_upcase_string(house.name)]["Phong#{room.name}"]["led_status#{chip}"]['active']
    if checkled_disable == 'Disable'
      render json: {status: 402}
      return false
    end

    response = firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/Phong#{room.name}/led_status#{chip}/status": set_status})
    ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: response.body
    head :no_content
  end

  def callvideo

  end
end
