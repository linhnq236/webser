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
    date = DateTime.now.to_date.strftime("%m-%Y")
    information_id = params[:information_id]
    room = Room.find(params[:room_id])
    use_service = UseService.find_by_information_id(information_id)
    info = Information.find(information_id)
    if use_service.nil?
      flash[:danger] = "#{info.name} chưa chọn dịch vụ"
      redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
    else
      if room.newelectric.nil? && room.newwater.nil?
        flash[:danger] = "Bạn chưa nhập chỉ số điện/nước giá trị mới"
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      else
        check_paytherent = Paytherent.where(senddate: date, information_id: information_id)

        if check_paytherent.size == 0
          paytherent = Paytherent.new(senddate: date, information_id: information_id)
          if paytherent.save
            NoticeMailer.notify_cost(information_id).deliver_now!
            if room.update(oldelectric: room.newelectric, newelectric: "", oldwater: room.newwater, newwater: "")
              flash[:notice] = "Gửi biên lai thanh toán tiền trọ thành công"
              redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
            else
              flash[:danger] = "Gửi biên lai thanh toán tiền trọ thất bại"
              redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
            end
          end
        else
          flash[:waring] = "Mail tháng này đã được gửi đi."
          redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
        end
      end
    end
  end
end
