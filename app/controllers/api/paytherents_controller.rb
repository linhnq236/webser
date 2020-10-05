module Api
  class PaytherentsController < ApplicationController
    include ServicesHelper
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def getPaytheRent
      paytherent = Paytherent.where(information_id: params[:information_id]).order("senddate DESC")
      render json: {data: paytherent}
    end
    def update
      senddate = params[:senddate]
      paytherent = Paytherent.where(information_id: params[:information_id], senddate: senddate)
      receivedate = DateTime.now.strftime("%Y-%m-%d %H:%M")
      if paytherent.update(receivedate: receivedate, status: 1)
        flash[:notice] = "Successful payment of accommodation"
        redirect_to paytherents_path
      else
        flash[:notice] = "Faild payment of accommodation"
        redirect_to paytherents_path
      end
    end

    def export
      array_data = []
      # @rooms = Room.where("house_id=#{current_user.house_id} AND information_id != ''")
      if current_user.admin == 1
        @rooms = Room.where("house_id=#{current_user.house_id}")
      else
        @rooms = Room.all
      end
      @rooms.each do |room|
        @paytherent = Paytherent.where(senddate: params[:senddate], information_id: room.information_id)
        @paytherent.each do |p|
          array_data.push(getDataExport(p.information_id, p.senddate, p.money, p.status))
        end
      end
      render json: {data: array_data}
    end

    def getDataExport id, senddate, money, status
      @room = Room.find_by_information_id(id)
      @house = House.find(@room.house_id.to_i)
      @infor = Information.find(id)

      return [
        'month': senddate,
        'fullname': @infor.name,
        'email':@infor.email,
        'phone1': @infor.phone1,
        'phone2': @infor.phone2,
        'house': @house.name,
        'room': @room.name,
        'status': status,
        'cost': @room.cost,
        'total': money
      ]
    end
  end
end
