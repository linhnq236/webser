module Api
  class UseServicesController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def getUseServices
      server_name = []
      service_amount = []
      use_service = UseService.find_by_information_id(params[:information_id])
      if use_service.nil?
        render json: {status: 304}
      else
        use_service["service_id"].each do |ser|
          service = Service.find(ser)
          server_name.push(service)
        end
        service_amount = use_service.amount
        render json: {status: 200, data: server_name, service_amount: service_amount}
      end
    end
  end
end
