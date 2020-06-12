class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_user_login, :led_status, :gettemperature
  FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'

  def check_user_login
    if user_signed_in?
      gon.user = current_user.id
    else
      gon.user = 0
    end
  end

  def led_status
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    response = firebase.get(FIREBASE_URL).body
    gon.leds = response
  end

  def gettemperature
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    gon.tmp = firebase.get(FIREBASE_URL).body
  end
end
