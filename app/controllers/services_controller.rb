class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all.order("status DESC")
    if current_user.admin == 1
      @array_use_services = []
      @users = User.where(house_id: current_user.house_id, admin: 0)
      @users.each do |user|
        info = Information.find_by_email(user.email)
        @array_use_services.push(info.id)
      end
      @array_services = []
      @array_use_services.each do |ar|
        use_service = UseService.find_by_information_id(ar)
        if !use_service.nil?
          @array_services.push(use_service)
        end
      end
      @use_services = @array_services
    else
      @use_services = UseService.all
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
      if @service.save
        flash[:notice] = I18n.t('mes.add_success', name: I18n.t('services_controller.services_name'))
        redirect_to services_path
      else
       flash[:warn]  = flash_errors(@service.errors)
       redirect_to services_path
      end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    result = ''
    array_result = []
    service = Service.find(params[:id])
    use_service = UseService.select(:service_id)
    use_service.each do |ser|
      result = (ser.service_id).include?(params[:id])
      array_result.push(result)
    end
    if array_result.include?(true)
      flash[:warning] = I18n.t('services_controller.error_delete')
      redirect_to services_path
    else
      service.destroy
      flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_delete'))
      redirect_to services_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def service_params
      params.require(:service).permit(:name, :cost, :status)
    end
end
