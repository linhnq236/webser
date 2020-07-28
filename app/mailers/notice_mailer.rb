class NoticeMailer < ApplicationMailer
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
    mail(to: "#{email}" ,subject: "#{subject}")
  end
end