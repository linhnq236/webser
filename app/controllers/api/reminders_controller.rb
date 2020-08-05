module Api
  class RemindersController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def getReminder
      start_time = params[:start_time]
      reminder = Reminder.where("start_time LIKE ?", start_time)
      render json: {data: reminder}
    end

    def create
      arrayid = params[:arrayid]
      arraytitle = params[:arraytitle]
      arraycontent = params[:arraycontent]
      checkerrors = []
      arrayid.each_with_index do |id, index|
        reminder = Reminder.find(id)
        if reminder.update(title: arraytitle[index], content: arraycontent[index])
          flash[:notice] = "Cập nhật thành công"
        else
          flash[:notice] = "Cập nhật thất bại"
        end
      end
      redirect_to "/reminders"
    end

    def check_mark
      reminder = Reminder.find(params[:id])
      # count = Reminder.find_by_mark(mark: 0)
      if reminder.update(mark: 1)
        head :no_content
        ActionCable.server.broadcast 'reminders_channel',
        reminders: 1
      end
  end
  end
end
