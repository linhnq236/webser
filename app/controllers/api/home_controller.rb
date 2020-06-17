module Api
  class HomeController < ApplicationController
    include ApplicationHelper
    skip_before_action :verify_authenticity_token
    FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
    FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  
    def led_status
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      leds = firebase.get(FIREBASE_URL).body
      render json: {data: leds}
    end

    def updatestatus
      status = params[:status]
      active = params[:active]
      area = params[:area]
      column = params[:column]
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      if(column == "TURNON" || column == "TURNOFF")
        byebug
      else
        response = firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}": active})
      end
      ActionCable.server.broadcast 'ledstatus_channel',
        ledstatus: response.body
      head :no_content
    end
    def settime
      status = params[:status]
      area = params[:area]
      column = params[:column]
      settime = params[:settime]

      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      response = firebase.update(FIREBASE_URL, {"#{area}/#{status}/#{column}": settime})
      ActionCable.server.broadcast 'ledstatus_channel',
        ledstatus: response.body
      head :no_content
    end
  end
end
