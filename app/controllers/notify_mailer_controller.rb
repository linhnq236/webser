class NotifyMailerController < ApplicationController
  def send_email
    @infors = Information.all.order("id ASC")
  end

  def send_to_email
    array_email = params[:email]
    title = params[:title]
    content = params[:content]
    array_email.each do |email|
      NoticeMailer.send_to_email_user(email, title,content).deliver_now!
    end
    flash[:notice] = "Gửi mail thành công"
    redirect_to '/send_email'
  end

  def send_mail_cost_room
    information_id = params[:information_id]
    room = Room.find(params[:room_id])
    if room.update(oldelectric: room.newelectric, newelectric: "", oldwater: room.newwater, newwater: "")
      NoticeMailer.notify_cost(information_id).deliver_now!
      flash[:notice] = "Gửi biên lai thanh toán tiền trọ thành công"
      redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
    else
      flash[:danger] = "Gửi biên lai thanh toán tiền trọ thất bại"
      redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
    end
  end
end
