class UsersController < ApplicationController
  def index
    @users =Information.where(mark: 0).order("created_at DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
    # @rooms = Room.all
  end

  def account
    if params[:disable].present?
      @users = User.where(disable: params[:disable])
    else
      @users = User.all
      # @infos =Information.order("created_at DESC")
    end
  end
end
