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

    def changed_email
      new_email = params[:new_email]
      current_email = params[:current_email]
      information_id = params[:information_id]
      info = Information.find(information_id)
      if info.update(email: new_email)
        user = User.find_by_email(current_email)
        if user.update(email: new_email)
          render json: {data: 200}
        else
          render json: {data: 202}
        end
      else
        render json: {data: 202}
      end
    end

  end
end
