class NoticeMailer < ApplicationMailer
  def notify_cost id
    @info = Information.find(id)
    # byebug
    # mail(to: @info.email ,subject: "Tien dong tro")
    mail(to: '1651120032@sv.ut.edu.vn' ,subject: "Tien dong tro")
  end
end
