class RemindersController < ApplicationController
  # GET /reminders
  # GET /reminders.json
  def index
    @reminders = Reminder.all
    puts "alo"
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
  end

  # GET /reminders/1/edit
  def edit
  end

  def create
    title = params[:title]
    content = params[:content]
    start_time = params[:start_time]
    end_time = params[:end_time]
    reminder = Reminder.new(title: title, content: content, start_time: start_time, end_time: end_time)
    if reminder.save
      flash[:notice] = "Tạo nhắc nhở thành công."
      redirect_to "/reminders"
    else
      flash[:danger] = "Lỗi."
      redirect_to "/reminders"
    end
  end

  def destroy
    reminder = Reminder.delete(params[:id])
    if !reminder.nil?
      flash[:notice] = "Xóa thành công"
      redirect_to "/reminders"
    else
      flash[:danger] = "Xóa bị lỗi"
      redirect_to "/reminders"
    end
  end
end
