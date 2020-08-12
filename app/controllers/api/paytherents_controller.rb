module Api
  class PaytherentsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def getPaytheRent
      paytherent = Paytherent.where(information_id: params[:information_id])
      render json: {data: paytherent}
    end
    def update
      senddate = params[:senddate]
      paytherent = Paytherent.where(information_id: params[:information_id], senddate: senddate)
      receivedate = DateTime.now.strftime("%Y-%m-%d %H:%M")
      if paytherent.update(receivedate: receivedate, status: 1)
        flash[:notice] = "Đóng tiền trọ thành công"
        redirect_to paytherents_path
      else
        flash[:notice] = "Đóng tiền trọ thất bại"
        redirect_to paytherents_path
      end
    end
  end
end
