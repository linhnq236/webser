module Api
  class MembersController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def info_members
      @members = Member.find_by_information_id(params[:information_id])
      render json: {members: @members}
    end

  end
end
