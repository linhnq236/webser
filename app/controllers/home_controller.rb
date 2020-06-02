class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  def index
  end
  def led_status
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    leds = firebase.get(FIREBASE_URL).body
    render json: {data: leds}
  end

  def updatestatus
    status = params[:status]
    active = params[:active]
    area = params[:area]

    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    if status == "LED_STATUS0"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS0": active})
    elsif status == "LED_STATUS1"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS1": active})
    elsif status == "LED_STATUS2"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS2": active})
    elsif status == "LED_STATUS3"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS3": active})
    elsif status == "LED_STATUS5"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS5": active})
    elsif status == "LED_STATUS6"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS6": active})
    elsif status == "LED_STATUS7"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS7": active})
    elsif status == "LED_STATUS8"
      response = firebase.update(FIREBASE_URL, {"#{area}/LED_STATUS8": active})
    end
    ActionCable.server.broadcast 'ledstatus_channel',
      ledstatus: response.body
    head :no_content
  end
end
