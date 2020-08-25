module Api
  class ReportsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :set_params, only: [:show]
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
      byebug
      report = Report.new(title: title, content: content, information_id: information_id)
      if report.save
        render json: {status: 200}
      else
        render json: {status: report.errors}
      end
    end
    private

    def set_params
      @report = Report.find(params[:id])
    end
  end
end
