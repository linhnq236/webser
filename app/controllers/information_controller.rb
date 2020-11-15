class InformationController < ApplicationController
  before_action :set_information, only: [:show, :edit, :update, :destroy]

  # GET /information
  # GET /information.json
  def index
    @information = Information.all
  end

  # GET /information/1
  # GET /information/1.json
  def show
  end

  # GET /information/new
  def new
    @information = Information.new
  end

  # GET /information/1/edit
  def edit
  end

  # POST /information
  # POST /information.json
  def create
    @information = Information.new(information_params)

    respond_to do |format|
      if @information.save
        format.html { redirect_to @information, notice: 'Information was successfully created.' }
        format.json { render :show, status: :created, location: @information }
      else
        format.html { render :new }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_information_customer
    if params[:information_id].present?
      infor = Information.find(params[:information_id])
      if infor.update(mark: 0)
        room = Room.find(params[:room_id])
        if room.update(information_id: params[:information_id], mark: 1)
          user = User.find_by_email(params[:email])
          if user.update(disable: 0)
            flash[:notice] = I18n.t('informations_controller.book_room')
            redirect_to houses_path
          end
        end
      end
    else
    firstname = params[:firstname]
    lastname = params[:lastname]
    sex = params[:sex]
    birth = params[:birth]
    indentifycard = params[:indentifycard]
    daterange = params[:daterange]
    placerange = params[:placerange]
    phone1 = params[:phone1]
    phone2 = params[:phone2]
    email = params[:email]
    permanent = params[:permanent]
    room_id = params[:room_id]
    house_id = params[:house_id]
    start = params[:start]
    deposit = params[:deposit]
    note = params[:note]
    information = Information.new(name: "#{firstname} #{lastname}", sex: sex, birth: birth, indentifycard: indentifycard,
      daterange: daterange, placerange: placerange, phone1: phone1, phone2: phone2, email: email, permanent: permanent, start: start, deposit: deposit, note: note)
      if information.save
        last_inf = Information.last.id
        room = Room.find(room_id)
        if room.update(information_id: last_inf, mark: 1)
          # // create account customer
          user = User.new(email: email, password: "123456", password_confirmation: "123456", house_id: house_id)
          if user.save
            # services = Service.where(status: 1)
            # services.each do |ser|
            #   InforServ.new(information_id: last_inf, service_id: ser.id, amount: 1).save
            # end
            flash[:notice] = I18n.t('mes.add_success', name: I18n.t('room.room_name'))
            redirect_to houses_path
          else
            flash[:notice] = I18n.t('mes.add_error', name: I18n.t('room.room_name'))
            redirect_to houses_path
          end
        else
          flash[:notice] = I18n.t('mes.add_error', name: I18n.t('room.room_name'))
          redirect_to houses_path
        end
      else
        flash[:notice] = I18n.t('informations_controller.add_customer')
        redirect_to "addcustomer/#{house_id}/#{room_id}?locale=#{params[:locale]}"
      end
    end
  end
  # PATCH/PUT /information/1
  # PATCH/PUT /information/1.json
  def update_information_customer
    firstname = params[:firstname]
    lastname = params[:lastname]
    sex = params[:sex]
    birth = params[:birth]
    indentifycard = params[:indentifycard]
    daterange = params[:daterange]
    placerange = params[:placerange]
    phone1 = params[:phone1]
    phone2 = params[:phone2]
    email = params[:email]
    permanent = params[:permanent]
    room_id = params[:room_id]
    house_id = params[:house_id]
    start = params[:start]
    deposit = params[:deposit]
    note = params[:note]
    information_id = params[:information_id]
    information = Information.find(information_id)
    if information.update(name: "#{firstname} #{lastname}", sex: sex, birth: birth, indentifycard: indentifycard,
       daterange: daterange, placerange: placerange, phone1: phone1, phone2: phone2, email: email, permanent: permanent, start: start, deposit: deposit, note: note)
       flash[:notice] = I18n.t('mes.action_success', action: I18n.t('mes.action_update'))
       redirect_to "/listcustomer/#{house_id}/#{room_id}/#{information_id}?locale=#{params[:locale]}"
     else
       flash[:notice] =  I18n.t('mes.action_fail', action: I18n.t('mes.action_update'))
       redirect_to "/listcustomer/#{house_id}/#{room_id}/#{information_id}?locale=#{params[:locale]}"
    end
  end
  def update
    respond_to do |format|
      if @information.update(information_params)
        format.html { redirect_to @information, notice: 'Information was successfully updated.' }
        format.json { render :show, status: :ok, location: @information }
      else
        format.html { render :edit }
        format.json { render json: @information.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /information/1
  # DELETE /information/1.json
  def destroy
    @information.destroy
    respond_to do |format|
      format.html { redirect_to information_index_url, notice: 'Information was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_information
      @information = Information.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def information_params
      params.require(:information).permit(:name, :sex, :birth, :indentifycard, :daterange, :placerange, :phone1, :phone2, :permanent, :start, :deposit, :note)
    end
end
