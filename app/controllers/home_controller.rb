class HomeController < ApplicationController
  include ApplicationHelper
  skip_before_action :verify_authenticity_token
  # FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  # FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  require "firebase_connect"

  def index
      # NoticeMailer.notify_cost("1").deliver_now!
  end
  def login

  end

  # def led_status
  #   firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
  #   leds = firebase.get(FIREBASE_URL).body
  #   render json: {data: leds}
  # end

  def updatestatus
    status = params[:status]
    active = params[:active]
    area = params[:area]
    column = params[:column]
    subcolumn = params[:subcolumn]
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    if(column == "turnon" || column == "turnoff")
      byebug
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

  def create_reminder

  end

  def voice
    name = params[:name]
    house_id = name.slice(0)
    room_id = name.slice(1)
    chip = name.slice(2)
    status = name.slice(3)
    set_status = ''
    if status == '1'
      set_status = 'on'
    else
      set_status = 'off'
    end
    house = House.find(house_id)
    room = Room.find_by_name(room_id)


    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    response = firebase.update(FIREBASE_URL, {"#{remove_space_upcase_string(house.name)}/Phong#{room.name}/led_status#{chip}/status": set_status})
    ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: response.body
    head :no_content
  end

  def callvideo

  end
end
