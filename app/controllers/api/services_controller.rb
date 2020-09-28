module Api
  class ServicesController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def show
      service = Service.find(params[:id])
      render json: {data: service}
    end
  end
end
