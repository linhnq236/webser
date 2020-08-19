module Api
  class SupportsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :set_params, only: [:show]

    def index
      support = Support.all
      render json: {data: support}
    end
  end
end
