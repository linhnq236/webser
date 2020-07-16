class UsersController < ApplicationController
  def index
    @users =Information.order("created_at DESC")
    @rooms = Room.all
    
  end
end
