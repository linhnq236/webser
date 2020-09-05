class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale
  before_action :check_user_login, :gettemperature, :check_manager
  # FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  # FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  require "firebase_connect"

  def check_user_login
    if user_signed_in?
      gon.user = current_user.id
      gon.reminders = Reminder.where(user_id: current_user.id).order("start_time DESC")
      gon.reports = Report.where(user_id: current_user.id).order("created_at DESC")
      gon.supports = Support.all
      gon.callvideos  = User.where("admin = 1 AND id != #{current_user.id}")
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      response = firebase.get(FIREBASE_URL).body
      if current_user.admin == 1
        gon.rooms = Room.where(house_id: current_user.house_id)
        gon.houses = House.where(id: current_user.house_id)
        house_name = House.find(current_user.house_id)
        gon.house_name = remove_space_upcase_string(house_name.name)
        gon.leds = response
      else
        gon.rooms = Room.all
        gon.houses = House.where("name != ?", 'MyHouse')
        gon.leds = response
      end
    else
      gon.user = 0
    end
  end

  def check_manager
    if user_signed_in?
      if current_user.admin == 0
        flash[:warning] = I18n.t('application_controller.not_permission')
        sign_out current_user
        redirect_to root_path
      elsif current_user.admin == 1 && current_user.disable == 1
        flash[:warning] = I18n.t('application_controller.acc_disable')
        sign_out current_user
        redirect_to root_path
      end
    end
  end

  def check_admin_login path
    # if user_signed_in?
    #   if current_user.admin == 2
    #     flash[:warning] = I18n.t('application_controller.not_admin_access')
    #     redirect_to path
    #   end
    # end
  end

  def gettemperature
    firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
    gon.tmp = firebase.get(FIREBASE_URL).body
  end

  def remove_space_upcase_string string
    re_space_string = string.gsub(" ","")
    upercase_string = re_space_string.upcase
    return upercase_string
  end

  def flash_errors errors
    error = errors.map {|key, value| value}
    return error.join(" ")
  end

  def getRoom information_id
    room = Room.find_by_information_id(information_id)
    return "Phong#{room.name}"
  end

  def getHouseRoom information_id
    room = Room.find_by_information_id(information_id)
    house = House.find(room.house_id)
    return remove_space_upcase_string(house.name)
  end
  # // Set I18n
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
 end

end
