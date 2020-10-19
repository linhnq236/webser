class AppsController < ApplicationController
  before_action  only: [:index] do
    check_manager_access_admin("/home")
  end
  def index
    @apps = App.all
  end

  def create
    if params['app_id'].present?
      @app = App.find(params['app_id'])
      if @app.update(set_params)
        flash[:notice] = "Updated successfully"
        redirect_to apps_path
      else
        flash[:notice] = @app.errors
        redirect_to apps_path
      end
    else
      @app = App.new(set_params)
      if @app.save
        flash[:notice] = "Create successfully"
        redirect_to apps_path
      else
        flash[:warn] = @app.errors
        redirect_to apps_path
      end
    end
  end

  private

  def set_params
    params.permit(:title, :text, :image, :backgroundColor, :textcolor)
  end
end
