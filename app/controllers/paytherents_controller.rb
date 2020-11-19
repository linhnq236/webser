class PaytherentsController < ApplicationController
  before_action :set_paytherent, only: [:show, :edit, :update, :destroy]

  # GET /paytherents
  # GET /paytherents.json
  def index
    @selectdates = Paytherent.order("senddate DESC").pluck(:senddate).uniq
    if current_user.admin == 1
      paytherents= []
      users = User.where(house_id: current_user.house_id, admin: 0)
      users.each do |user|
        info = Information.find_by_email(user.email)
        paytherent = Paytherent.where(information_id: info.id).order("senddate DESC")
        paytherent.each do |p|
          paytherents.push(p)
        end
      end
      @paytherents = paytherents.paginate(:page => params[:page], :per_page => ENV["DEFAULT_RENTAL_PER_PAGE"])
    else
      @paytherents = Paytherent.all.order("senddate DESC").paginate(:page => params[:page], :per_page => ENV["DEFAULT_RENTAL_PER_PAGE"])
    end
  end

  # GET /paytherents/1
  # GET /paytherents/1.json
  def show
  end

  # GET /paytherents/new
  def new
    @paytherent = Paytherent.new
  end

  # GET /paytherents/1/edit
  def edit
  end

  # POST /paytherents
  # POST /paytherents.json
  def create
    @paytherent = Paytherent.new(paytherent_params)

    respond_to do |format|
      if @paytherent.save
        format.html { redirect_to @paytherent, notice: 'Paytherent was successfully created.' }
        format.json { render :show, status: :created, location: @paytherent }
      else
        format.html { render :new }
        format.json { render json: @paytherent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paytherents/1
  # PATCH/PUT /paytherents/1.json
  def update
    respond_to do |format|
      if @paytherent.update(paytherent_params)
        format.html { redirect_to @paytherent, notice: 'Paytherent was successfully updated.' }
        format.json { render :show, status: :ok, location: @paytherent }
      else
        format.html { render :edit }
        format.json { render json: @paytherent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paytherents/1
  # DELETE /paytherents/1.json
  def destroy
    @paytherent.destroy
    respond_to do |format|
      format.html { redirect_to paytherents_url, notice: 'Paytherent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paytherent
      @paytherent = Paytherent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paytherent_params
      params.require(:paytherent).permit(:senddate, :receivedate, :status)
    end
end
