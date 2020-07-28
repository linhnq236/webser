module Api
  class InformationController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def getinfo
      info = Information.find(params[:id])
      render json: {data: info}
    end

    def updateInfo
      birth = params[:birth]
      name = params[:name]
      indentifycard = params[:indentifycard]
      daterange = params[:daterange]
      placerange = params[:placerange]
      phone1 = params[:phone1]
      phone2 = params[:phone2]
      permanent = params[:permanent]
      # deposit = params[:deposit]
      note = params[:note]
      info = Information.find(params[:id])
      if info.update(name: name, birth: birth, indentifycard: indentifycard, phone1: phone1, phone2: phone2, note: note)
        render json: {status: 200}
      else
        render json: {status: 402}
      end
    end

    def getOldCustomer
      info = Information.where(mark: 1)
      render json: {data: info}
    end

  end
end
