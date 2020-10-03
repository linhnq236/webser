module Api
  class AppsController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :set_params, only: [:show]
    def appSlider
      apps = App.order("created_at DESC")
      render json: {slides: apps}
    end

    def delete_slider
      App.delete(params[:app_id])
      render json: {status:200}
    end
    def show
      render json: {data: @app}
    end

    private

    def set_params
      @app = App.find(params[:id])
    end
  end
end
