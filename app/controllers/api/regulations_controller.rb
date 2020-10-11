module Api
  class RegulationsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def getRegulations
      room = Room.find_by_information_id(params[:information_id])
      regulations = Regulation.where(house_id: room.house_id)
      render json: {regulations: regulations, house_name: room.house.name}
    end
  end
end
