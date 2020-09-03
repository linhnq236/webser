class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]
  before_action  only: [:new, :show, :deletehouse, :payroom, :edit, :destroy] do
    check_admin_login("/houses")
  end
  FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  # GET /houses
  # GET /houses.json
  def index
    if current_user.admin == 1
      @houses = House.where(id: current_user.house_id)
    else
      @houses = House.all
    end
    @rooms = Room.order("name ASC")
    @informations = Information.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  # GET /houses/new
  def new
    @house = House.new
    @cities = City.all
    @districts = District.all
  end

  # GET /houses/1/edit
  def edit
    @cities = City.all
    @districts = District.all
    @wards = Ward.all
  end

  # POST /houses
  # POST /houses.json
  def create
    name = params[:name]
    city_id = params[:city_id]
    district_id = params[:district_id]
    ward_id = params[:ward_id]
    number = params[:number]
    road = params[:road]

    @house = House.new(name: name, city_id: city_id, district_id: district_id, ward_id: ward_id, address: "#{number} #{road}")
    if @house.save
      flash[:notice] = I18n.t('mes.add_success', name: I18n.t('house.house_name'))
      redirect_to "/houses"
    else
      flash[:notice] = I18n.t('mes.add_error', name: I18n.t('house.house_name'))
      redirect_to "/houses/new"
    end
  end

  def deletehouse
    rooms = Room.where(house_id: params[:id]).pluck(:id)
    check = 0
    rooms.each do |r|
      check_room = Room.find_by_information_id(r)
      if !check_room.nil?
        check += 1
      end
    end
    if check !=0
      flash[:warning] = I18n.t('houses_controller.not_check_out')
      redirect_to houses_path
    else
      for i in 0..rooms.size
        Room.delete(rooms[i])
      end
      house = House.find(params[:id])
      name = house.name
      re_space_house_name = name.gsub(" ","")
      upercase_house_name = re_space_house_name.upcase

      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      firebase.delete("#{upercase_house_name}")
      house = House.delete(params[:id])
      flash[:notice] = I18n.t('mes.delete_success', name: I18n.t('house.house_name'))
      redirect_to houses_path
    end
  end
  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: I18n.t('mes.update_success', name: I18n.t('house.house_name')) }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def house_params
      params.permit(:name, :city, :distric, :ward, :address)
    end
end
