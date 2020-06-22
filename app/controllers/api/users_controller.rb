module Api
  require 'bcrypt'

  class UsersController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def account
      name = ''
      user = User.find_by_email(params[:email])
      user_pass = BCrypt::Password.new(user.encrypted_password)
      if user_pass == params[:password]
        infor = Information.where(email: params[:email])
        infor.each do |n|
          name = n.name
        end
        render json: {data: name, password: params[:password]}
      else
        render json: {data: 0}
      end
    end
  end
end
