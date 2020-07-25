class NoticeMailer < ApplicationMailer
  def notify_cost id
    @info = Information.find(id)
    # byebug
    # mail(to: @info.email ,subject: "Tien dong tro")
    mail(to: 'lockupin@gmail.com' ,subject: "Tien dong tro")
  end
end
