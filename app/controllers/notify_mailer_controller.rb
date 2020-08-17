class NotifyMailerController < ApplicationController
  include ServicesHelper
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
  def getMoneyPerMonth(id)
    array_sum = []
    @use_services = UseService.find_by_information_id(id)
    @services = Service.all
    @room = Room.find_by_information_id(id)
    @house = House.find(@room.house_id.to_i)
    @use_services.service_id.each_with_index do |s, i|
      if getServiceName(@services,s) == 'Điện'
        sum_amount_cost(getServiceCost(@services,s), use_electric_water(@room.oldelectric, @room.newelectric))
        array_sum.push(sum_amount_cost(getServiceCost(@services,s), use_electric_water(@room.oldelectric, @room.newelectric)))
      elsif getServiceName(@services,s) == 'Nước'
        sum_amount_cost(getServiceCost(@services,s),use_electric_water(@room.oldwater, @room.newwater))
        array_sum.push(sum_amount_cost(getServiceCost(@services,s),use_electric_water(@room.oldwater, @room.newwater)))
      else
        sum_amount_cost(getServiceCost(@services,s), @use_services.amount[i])
        array_sum.push(sum_amount_cost(getServiceCost(@services,s), @use_services.amount[i]))
      end
    end
    money = array_sum.inject{ |sum,e| sum += e.to_i }.to_i + @room.cost.to_i
    return money
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
          NoticeMailer.notify_cost(information_id).deliver_now!
          paytherent = Paytherent.new(senddate: date, information_id: information_id, money: getMoneyPerMonth(information_id))
          if paytherent.save
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
