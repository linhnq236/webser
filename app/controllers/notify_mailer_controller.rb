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
end
