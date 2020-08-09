class NoticeMailer < ApplicationMailer
    default from: "1651120032@sv.ut.edu.vn"
    layout 'mailer'

  def notify_cost id
    @month = DateTime.now.to_date.strftime("%m/%Y")
    @info = Information.find(id)
    @use_services = UseService.find_by_information_id(id)
    @services = Service.all
    @room = Room.find_by_information_id(id)
    @house = House.find(@room.house_id.to_i)

    mail(to: "#{@info.email}" ,subject: "Đóng tiền thuê trọ")
  end

  def send_to_email_user email, subject, content
    @content = "#{content}"
    mail(to: "#{email}" ,subject: "#{subject}")
  end
end
