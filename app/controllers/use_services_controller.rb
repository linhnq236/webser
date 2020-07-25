class UseServicesController < ApplicationController
  def use_service
      use_service = UseService.find_by_information_id(params[:information_id])
      if use_service.nil?
        userser = UseService.new(userser_params.merge(information_id: params[:information_id]))
        if userser.save
          flash[:notice] = "Lưu thành công"
          redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
        else
          a = userser.errors
        end
      else
        if use_service.update(userser_params)
          flash[:notice] = "Cập nhật thành công"
          redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
        end
      end
  end

  private

  def userser_params
    params.permit(service_id:[], amount:[])
  end
end
