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

      reponse_leds = firebase.get(FIREBASE_URL).body

      ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: reponse_leds
        head :no_content
    end

  end
end
