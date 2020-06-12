class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
    @rooms = Room.order("id ASC")
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
      flash[:notice] = "Them nha moi"
      redirect_to "/houses"
    else
      flash[:notice] = "Them that bai"
      redirect_to "/houses/new"
    end
  end

  def deletehouse
    rooms = Room.where(house_id: params[:id]).pluck(:id)
    for i in 0..rooms.size
      Room.delete(rooms[i])
    end
    house = House.delete(params[:id])
    flash[:notice] = "Xóa thành công"
    redirect_to houses_path
  end
  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
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
