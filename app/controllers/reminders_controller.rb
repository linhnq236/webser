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
      flash[:notice] =  I18n.t('reminders_controller.reminder_action', action: I18n.t('reminders_controller.action_success'))
      redirect_to "/reminders"
    else
      flash[:danger] = I18n.t('reminders_controller.reminder_action', action: I18n.t('reminders_controller.action_fail'))
      redirect_to "/reminders"
    end
  end

  def destroy
    reminder = Reminder.delete(params[:id])
    if !reminder.nil?
      flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_delete'))
      redirect_to "/reminders"
    else
      flash[:danger] =  I18n.t('mes.action_fail', action: I18n.t('mes.action_delete'))
      redirect_to "/reminders"
    end
  end
end
