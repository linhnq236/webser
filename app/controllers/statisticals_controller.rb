class StatisticalsController < ApplicationController
  include ApplicationHelper

  def index
    @rooms = Room.where(house_id: current_user.house_id)
    @users = User.where("admin < ? AND house_id = ?", 2, current_user.house_id)
    @members = Member.all
    if current_user.admin == 2
      @rooms = Room.all
      @users = User.where("admin < ?", 2)
      @paytherent_pays = Paytherent.where(status: 1)
    end
  end
end
