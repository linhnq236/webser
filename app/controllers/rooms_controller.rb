class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :payroom]
  before_action  only: [:room_fast, :destroy, :new] do
    check_manager_access_admin("/houses")
  end

  # FIREBASE_URL    = 'https://iotpro-58c44.firebaseio.com/'
  # FIREBASE_SECRET = 'F4mMmNXp1CPYvJYX5KwtrLifqw6UvVO4fyCUKhoj'
  require "firebase_connect"

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
    @houses = House.where("name != ?", 'MyHouse').order("id DESC")

  end

  # GET /rooms/1/edit
  def edit
    @houses = House.order("id DESC")
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @quantum = params[:quantum]
    @name = params[:name]
    house_id = params[:house_id]
    cost = params[:cost]
    amount = params[:amount]
    width = params[:width]
    length = params[:length]
    description = params[:description]
    ligth = params[:ligth]
    fan = params[:fan]
    powersocket = params[:powersocket]
    @room = Room.new(name: @name, cost: cost, house_id: house_id, width: width, length: length, description: description)
    if (ligth.to_i + fan.to_i + powersocket.to_i + 1) != 8
        flash[:warning] =  "Total devices are 8, please !"
        redirect_to houses_path
    else
      if Room.where(name: @room.name, house_id: @room.house_id).exists?
        flash[:warn] =  I18n.t('rooms_controller.exist_room')
        redirect_to houses_path
      else
        for i in 0...@quantum.to_i
          house = House.find(@room.house_id)
          name = house.name
          re_space_house_name = name.gsub(" ","")
          upercase_house_name = re_space_house_name.upcase
          @room = Room.new(name: (@name.to_i+i), cost: cost, house_id: house_id, width: width, length: length, description: description)
          if @room.save
            create_house_room_firebase(upercase_house_name, @room.name, ligth, fan, powersocket)
            flash[:notice] =  I18n.t('rooms_controller.new_room')
          else
            flash[:warning] =  flash_errors(@room.errors)
          end
        end
        redirect_to houses_path
      end
    end
  end

  def room_fast
    @houses = House.where("name != ?", 'MyHouse').order("id DESC")
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
      if Room.where(name: room.name, house_id: room.house_id).exists?
        flash[:warn] =  I18n.t('rooms_controller.exist_room')
      else
        if room.save
          flash[:notice] = I18n.t('rooms_controller.new_room')
        else
          flash[:notice] = I18n.t('rooms_controller.new_room_fail')
        end
      end
    end
    redirect_to houses_path
  end

  def addcustomer
    @house = House.where(id: params[:house_id])
    @room = Room.where(id: params[:room_id])
    @services = Service.all.order("status DESC")
    if params[:information_id].present?
      @infor = Information.find(params[:information_id])
    end
  end

  def listcustomer
    @house = House.where(id: params[:house_id])
    @room = Room.where(id: params[:room_id])
    @information = Information.where(id: params[:information_id])
    @check_use_service = UseService.find_by_information_id(params[:information_id])
    if @check_use_service.nil?
      @services = Service.all.order("status DESC")
    else
      @services = Service.all.order("status DESC")
      @use_services = UseService.where(information_id: params[:information_id])
    end
    check_member = Member.find_by_information_id(params[:information_id])
    if !check_member.nil?
      @member = check_member
    end
  end

  def payroom
    paytherent = Paytherent.where(information_id: params[:information_id], status: 0)
    if paytherent.size !=0
      flash[:warning] = I18n.t('rooms_controller.payroom_before')
      redirect_to houses_path
    else
      if @room.update(information_id: "", mark: 0, oldelectric: 0, newelectric: 0, oldwater: 0, newwater: 0)
        inf = Information.find(params[:information_id])
        user = User.find_by_email(inf.email)
        if user.update(disable: 1)
          if inf.update(mark: 1)
            UseService.where(information_id: params[:information_id]).delete_all
            Member.where(information_id: params[:information_id]).delete_all
            # Paytherent.where(information_id: params[:information_id]).delete_all
            flash[:notice] = I18n.t('rooms_controller.payroom_success')
            redirect_to houses_path
          end
        end
      else
        flash[:warning] = I18n.t('rooms_controller.payroom_fail')
        redirect_to houses_path
      end
    end
  end

  def indexservice
    oldelectric = params[:oldelectric]
    newelectric = params[:newelectric]
    oldwater = params[:oldwater]
    newwater = params[:newwater]
    room = Room.find(params[:room_id])
    if room.update(oldelectric: oldelectric, newelectric: newelectric, oldwater: oldwater, newwater: newwater)
      flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_update'))
      redirect_to "/listcustomer/#{params[:house_id]}/#{params[:room_id]}/#{params[:information_id]}"
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
      format.html { redirect_to houses_path, notice: I18n.t('mes.action_success', action: I18n.t('mes.action_delete')) }
      format.json { head :no_content }
    end
  end

  def cancel_infor
    information_id = params[:information_id]
    infor = Information.find(information_id)
    user = User.find_by_email(infor.email)
    User.delete(user.id)
    use_service = UseService.find_by_information_id(information_id)
    if !use_service.nil?
      UseService.delete(use_service.id)
    end
    room = Room.find_by_information_id(information_id)
    room.update(information_id: "", mark: 0, oldelectric: "", newelectric: "", oldwater: "", newwater: "")
    Information.delete(information_id)
    flash[:notice] = t("room.mes_cancel_room")
    redirect_to houses_path
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

    def create_house_room_firebase house_name, room_name, ligth, fan, powersocket
      datetime = "0000-00-00 00:00"
      firebase = Firebase::Client.new(FIREBASE_URL, FIREBASE_SECRET)
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/led_status0/kind": "0"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/led_status0/status": "Off"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/led_status0/turnon": "#{datetime}"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/led_status0/turnoff": "#{datetime}"})
      firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/led_status0/active": "Enable"})
      # -------------------------------------------------------------------------------------------------------
      elseleds = ['led_status1', 'led_status2', 'led_status3', 'led_status5', 'led_status6', 'led_status7', 'led_status8']
      array_lights = []
      array_fans = []
      array_powersockets = []
      for i in 0...ligth.to_i
        array_lights.push(elseleds[i])
      end
      for i in ligth.to_i...(ligth.to_i + fan.to_i)
        array_fans.push(elseleds[i])
      end
      for i in (ligth.to_i+fan.to_i)...elseleds.size
        array_powersockets.push(elseleds[i])
      end

      array_lights.each do |l|
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{l}/kind": "1"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{l}/status": "Off"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{l}/turnon": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{l}/turnoff": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{l}/active": "Enable"})
      end

      array_fans.each do |f|
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{f}/kind": "2"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{f}/status": "Off"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{f}/turnon": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{f}/turnoff": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{f}/active": "Enable"})
      end

      array_powersockets.each do |p|
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{p}/kind": "3"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{p}/status": "Off"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{p}/turnon": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{p}/turnoff": "#{datetime}"})
        firebase.update(FIREBASE_URL, {"#{house_name}/Phong#{room_name}/#{p}/active": "Enable"})
      end
    end
end
