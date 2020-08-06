class NoticeMailer < ApplicationMailer
    default from: "1651120032@sv.ut.edu.vn"
    layout 'mailer'

  def notify_cost id
    @info = Information.find(id)
    @use_services = UseService.find(id)
    @services = Service.all
    @room = Room.find_by_information_id(id)
    @house = House.find(@room.house_id)

    mail(to: "#{@info.email}" ,subject: "Đóng tiền thuê trọ")
  end

  def send_to_email_user email, subject, content
    @content = "#{content}"
    mail(to: "saqibghaffar324@gmail.com" ,subject: "#{subject}")
  end
end
