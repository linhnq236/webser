module Api
  class HousesController < ApplicationController
    def getdistrict
      if params[:city].present?
        @city_id = params[:city]
        districts = District.where(city_id: @city_id)
      end
      render json: {data: districts}
    end

    def getward
      if params[:district].present?
        @district_id = params[:district]
        wards = Ward.where(district_id: @district_id)
      end
      render json: {data: wards}
    end
  end
end
