class MembersController < ApplicationController
  def create
    member = Member.find_by_information_id(params[:information_id])
    if member.nil?
      new_member = Member.new(members_params.merge(information_id: params[:information_id]))
      if new_member.save
        flash[:notice] = "Lưu thành công"
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      else
        flash[:notice] = "Lưu thất bại"
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      end
    else
      if member.update(members_params)
        flash[:notice] = "Lưu thành công"
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      else
        flash[:notice] = "Lưu thất bại"
        redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
      end
    end
  end

  private

  def members_params
    params.require(:member).permit(name:[], sex:[], birth:[], indentifycard:[], address:[], phone:[])
  end
end
