class UsersController < ApplicationController
  def index
    @users =Information.where(mark: 0).order("created_at DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
    # @rooms = Room.all
  end

  def account
    if params[:disable].present?
      @users = User.where("disable = ?  AND  admin < ? ", params[:disable],2)
    else
      @users = User.where("admin < ? ", 2).order("admin DESC")
      # @infos =Information.order("created_at DESC")
    end
  end

  def createaccount
    @user = User.new(email: params[:email], password: "123456", password_confirmation: "123456", admin: 1)
    if @user.save
      flash[:notice] = 'Tạo người quản lý mới.'
      redirect_to account_path
    else
     flash[:warn]  = flash_errors(@user.errors)
     redirect_to account_path
    end
  end
end
