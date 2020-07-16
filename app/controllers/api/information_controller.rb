module Api
  class InformationController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def getinfo
      info = Information.find(params[:id])
      render json: {data: info}
    end


  end
end
