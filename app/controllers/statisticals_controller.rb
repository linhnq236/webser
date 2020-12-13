class StatisticalsController < ApplicationController
  include ApplicationHelper

  def index
    @year = 2020
    @status = 1
    @rooms = Room.where(house_id: current_user.house_id)
    @users = User.where("admin < ? AND house_id = ?", 2, current_user.house_id)
    @members = Member.all
    if current_user.admin == 2
      @rooms = Room.all
      @users = User.where("admin < ?", 2)
      if params['status'].present?
        @year =  params["date"]["year(1i)"]
        @pattern = "%#{@year}%"
        @status = params[:status]
        @paytherent_pays = Paytherent.where("status = ? AND paytherents.senddate LIKE ?", @status, @pattern)
      else
        @pattern = "%#{@year}%"
        @paytherent_pays = Paytherent.where("status = ? AND paytherents.senddate LIKE ?", @status, @pattern)
      end
    end
  end
end
