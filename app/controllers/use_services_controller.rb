class UseServicesController < ApplicationController
  before_action :set_params, only: [:destroy]
  def use_service
      use_service = UseService.find_by_information_id(params[:information_id])
      if use_service.nil?
        userser = UseService.new(userser_params.merge(information_id: params[:information_id]))
        if userser.save
          flash[:notice] = I18n.t('use_services_controller.create')
          redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
        else
          a = userser.errors
        end
      else
        if use_service.update(userser_params)
          flash[:notice] = I18n.t("use_services_controller.update")
          redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
        end
      end
  end

  def destroy
    @use_service.destroy
    flash[:notice] =  I18n.t("use_services_controller.delete")
    redirect_to services_path
  end

  private

  def set_params
    @use_service = UseService.find(params[:id])
  end
  def userser_params
    params.permit(service_id:[], amount:[])
  end
end
