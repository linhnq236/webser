module Api
  require 'bcrypt'

  class UsersController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    before_action :set_params, only: [:active_acc]
    def account
      name = ''
      id = ''
      user = User.find_by_email(params[:email])
      if user.nil?
        render json: {status: 204}
      else
  	user_pass = BCrypt::Password.new(user.encrypted_password)
        if user_pass == params[:password]
           infor = Information.where(email: params[:email])
           infor.each do |n|
             name = n.name
             id = n.id
           end
           render json: {status: 200, username: name, id: id, disable: user.disable, admin: user.admin }
        else
          render json: {status: 204}
        end
      end

    end

    def active_acc
      if @user.update(disable: params[:active])
        flash[:notice] = t("mes.action_success", action: t("mes.action_update"))
        redirect_to account_path
      else
        flash[:notice] = t("mes.action_fail", action: t("mes.action_update"))
        redirect_to account_path
      end
    end

    private

    def set_params
      @user = User.find(params[:id])
    end
  end
end
