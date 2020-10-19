class RegulationsController < ApplicationController
  before_action :set_regulation, only: [:show, :edit, :update, :destroy]

  # GET /regulations
  # GET /regulations.json
  def index
    if current_user.admin == 1
      @regulations = Regulation.where(house_id: current_user.house_id)
    else
      @regulations = Regulation.all
    end
  end

  # GET /regulations/1
  # GET /regulations/1.json
  def show
  end

  # GET /regulations/new
  def new
    @regulation = Regulation.new
    if current_user.admin == 1
      @houses = House.where(id: current_user.house_id)
    else
      @houses = House.where("name != ?", 'MyHouse')
    end
  end

  # GET /regulations/1/edit
  def edit
    @houses = House.all
  end

  # POST /regulations
  # POST /regulations.json
  def create
    @regulation = Regulation.new(regulation_params)

    if @regulation.save
      flash[:notice] = 'Regulation was successfully created.'
      redirect_to regulations_url
    else
      flash[:warn] = flash_errors(@regulation.errors)
      redirect_to regulations_url
    end
  end

  # PATCH/PUT /regulations/1
  # PATCH/PUT /regulations/1.json
  def update
    respond_to do |format|
      if @regulation.update(regulation_params)
        format.html { redirect_to regulations_url, notice: 'Regulation was successfully updated.' }
        format.json { render :show, status: :ok, location: @regulation }
      else
        format.html { render :edit }
        format.json { render json: @regulation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regulations/1
  # DELETE /regulations/1.json
  def destroy
    @regulation.destroy
    respond_to do |format|
      format.html { redirect_to regulations_url, notice: 'Regulation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regulation
      @regulation = Regulation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def regulation_params
      params.require(:regulation).permit(:title, :description, :house_id)
    end
end
