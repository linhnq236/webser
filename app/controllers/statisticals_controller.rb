class StatisticalsController < ApplicationController
  def index
    @rooms = Room.all
    @users = User.all
    @members = Member.all
  end
end
