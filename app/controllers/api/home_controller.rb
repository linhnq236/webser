module Api
  class HomeController < ApplicationController
    include ApplicationHelper
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
    FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'

    def led_status
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      leds = firebase.get(FIREBASE_URL).body
      render json: {leds: leds}
    end

  end
end
