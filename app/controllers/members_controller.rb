class MembersController < ApplicationController
  def show_detail_members
    @info = Information.find(params[:information_id])
    @member = Member.find_by_information_id(params[:information_id])
  end
  def create
    member = Member.find_by_information_id(params[:information_id])
    if member.nil?
      new_member = Member.new(members_params.merge(information_id: params[:information_id]))
      if new_member.save
        flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_create'))
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      else
        flash[:notice] = I18n.t('mes.action_fail', action: I18n.t('mes.action_create'))
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      end
    else
      if member.update(members_params)
        flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_create'))
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      else
        flash[:notice] = I18n.t('mes.action_fail', action: I18n.t('mes.action_create'))
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      end
    end
  end

  private

  def members_params
    params.require(:member).permit(name:[], sex:[], birth:[], indentifycard:[], address:[], phone:[])
  end
end
