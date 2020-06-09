class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_user_login
  def check_user_login
    if user_signed_in?
      gon.user = current_user.id
    else
      gon.user = 0
    end
  end
end
