module Api
  class ReportsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :set_params, only: [:destroy, :show]
    # before_action :set_params_information, only: [:show]

    def index
      @reports = Report.where(user_id: current_user.id)
      render json: {data: @reports}
    end
    def show
      render json: {data: @report}
    end

    def showpopup
      @reports = Report.where(information_id:params[:id]).order("created_at DESC")
      render json: {data: @reports}
    end
    def create
      title = params[:title]
      content = params[:content]
      information_id = params[:information_id]
      room = Room.find_by_information_id(information_id)
      # user = User.where(house_id: room.house_id, admin: 1)
      # user.each do |u|
        report = Report.new(title: title, content: content, information_id: information_id, house_id: room.house_id)
        if report.save
          render json: {status: 200}
        else
          render json: {status: report.errors}
        end
      # end
    end

    def status_feedback
      report_id = params[:report_id]
      status = params[:status]
      @report = Report.find(report_id)
      if @report.update(mark: status)
        render json: {status: 200}
      else
        render json: {status: 402}
      end
    end

    def deleteId
      Report.delete(params[:id])
      render json: {status: 200}
    end

    def destroy
      @report.destroy
      render json: {status: 200}
    end
    private

    def set_params
      @report = Report.find(params[:id])
    end
    def set_params_information
      @report = Report.find_by_information_id(params[:id])
    end
  end
end
