class UsersController < ApplicationController
  def index
    @users =Information.where(mark: 0).order("created_at DESC")
    @rooms = Room.all

  end

  def account
    @infos =Information.order("created_at DESC")
    @users = User.all
  end
end
