class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :payroom]
  FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @houses = House.order("id DESC")
  end

  # GET /rooms/1/edit
  def edit
    @houses = House.order("id DESC")
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    house = House.find(@room.house_id)
    name = house.name
    re_space_house_name = name.gsub(" ","")
    upercase_house_name = re_space_house_name.upcase
    respond_to do |format|
      if @room.save
        create_house_room_firebase(upercase_house_name, @room.name)
        format.html { redirect_to houses_path, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def room_fast
    @houses = House.order("id DESC")

  end
  def roomfast
    start = params[:start]
    finsh = params[:end]
    house_id = params[:house_id]
    amount = params[:amount]
    width = params[:width]
    length = params[:length]
    description = params[:description]
    cost = params[:cost]
    house = House.find(house_id)
    name = house.name
    re_space_house_name = name.gsub(" ","")
    upercase_house_name = re_space_house_name.upcase
    for i in start.to_i..finsh.to_i
      room = Room.new(name: i, amount: amount, cost: cost, width: width, length: length, description: description, house_id: house_id)
      create_house_room_firebase(upercase_house_name, i)
      if room.save
        flash[:notice] = "Them phong moi thanh cong"
      else
        flash[:notice] = "Them phong moi that bai"
      end
    end
    redirect_to houses_path
  end

  def addcustomer
    @house = House.where(id: params[:house_id])
    @room = Room.where(id: params[:room_id])
    @services = Service.all
  end

  def listcustomer
    @house = House.where(id: params[:house_id])
    @room = Room.where(id: params[:room_id])
    @information = Information.where(id: params[:information_id])
    @services = Service.all
  end

  def information_service
    byebug
  end

  def payroom
    if @room.update(information_id: "")
      flash[:notice] = "Trả phòng thành công !"
      redirect_to houses_path
    else
      flash[:warning] = "Trả phòng thất bại !"
      redirect_to houses_path
    end
  end
  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update

    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to houses_path, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to houses_path, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :cost, :length, :width, :amount, :allow, :description, :picture, :house_id, service_id: [], )
    end

    def create_house_room_firebase house_name, room_name
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS0/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS0/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS0/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS1/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS1/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS1/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS2/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS2/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS2/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS3/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS3/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS3/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS5/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS5/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS5/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS6/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS6/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS6/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS7/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS7/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS7/TURNOFF": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS8/STATUS": "OFF"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS8/TURNON": "13:00"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/LED_STATUS8/TURNOFF": "13:00"})
    end
end
