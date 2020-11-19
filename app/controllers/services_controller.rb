class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all.order("status DESC")
    if current_user.admin == 1
      @array_use_services = []
      @rooms = Room.where(house_id: current_user.house_id).merge(Room.where.not(information_id: nil)).order("id ASC")
      @rooms.each do |room|
        use= UseService.find_by_information_id(room.information_id)
        @array_use_services.push(use)
      end
      @use_services = @array_use_services.paginate(:page => params[:page], :per_page => ENV["DEFAULT_SERVICE_PER_PAGE"])

    else
      @use_services = UseService.all.paginate(:page => params[:page], :per_page => ENV["DEFAULT_SERVICE_PER_PAGE"])
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
    if Service.where(name: @service.name).exists?
      service = Service.find_by_name(@service.name)
      if service.update(service_params)
        flash[:notice] = I18n.t('mes.update_success', name: I18n.t('services_controller.services_name'))
        redirect_to services_path
      end
    else
      if @service.save
        flash[:notice] = I18n.t('mes.add_success', name: I18n.t('services_controller.services_name'))
        redirect_to services_path
      else
       flash[:warn]  = flash_errors(@service.errors)
       redirect_to services_path
      end
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
