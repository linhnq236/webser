class UsersController < ApplicationController

  def index
    # @users =Information.where(mark: 0).order("created_at DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
    # @rooms = Room.all
    if current_user.admin == 1
      array_infos = []
      @rooms = Room.where(house_id: current_user.house_id).merge(Room.where.not(information_id: nil)).order("id ASC")
      @rooms.each do |u|
        infor = Information.where(id: u.information_id, mark: 0)
        infor.each do |info|
          array_infos.push(info)
        end
      end
      @users = array_infos.paginate(:page => params[:page], :per_page => ENV["DEFAULT_CUSTOMER_PER_PAGE"])
    else
      @users =Information.where(mark: 0).order("created_at DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_CUSTOMER_PER_PAGE"])
    end
  end

  def account
    @houses = House.where("name != ?", 'MyHouse')
    if current_user.admin == 1
      if params[:disable].present?
        @users = User.where("disable = ?  AND  admin < ? AND house_id =? ", params[:disable],2, current_user.house_id).paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
      else
        @users = User.where("admin < ? AND house_id = ? ", 2, current_user.house_id).order("admin DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
        # @infos =Information.order("created_at DESC")
      end
    else
      if params[:disable].present?
        @users = User.where("disable = ?  AND  admin < ?",  params[:disable],2).paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
      else
        @users = User.where("admin < ?", 2).order("admin DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_USER_PER_PAGE"])
      end
    end
  end

  def createaccount
    @user = User.new(email: params[:email], password: "123456", password_confirmation: "123456", admin: 1, house_id: params[:house_id])
    if @user.save
      flash[:notice] =  I18n.t("users_controller.create")
      redirect_to account_path
    else
     flash[:warn]  = flash_errors(@user.errors)
     redirect_to account_path
    end
  end

  def change_avata

  end
end
