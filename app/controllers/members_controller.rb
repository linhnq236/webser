class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  def addmembers
    house_id = params[:house_id]
    room_id = params[:room_id]
    information_id = params[:information_id]
    @members = Member.new(set_member_params.merge(information_id: information_id))
    if @members.save
      flash[:notice] = "Thêm thành công"
      redirect_to "/listcustomer/#{house_id}/#{room_id}/#{information_id}"
    else
      flash[:notice] = "Thêm thất bại"
      redirect_to "/listcustomer/#{house_id}/#{room_id}/#{information_id}"
    end
  end

  def info_members
    @information = Information.find(params[:information_id])
    @members = Member.find_by_information_id(params[:information_id])
  end
  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :birth, :sex, :indentifycard, :phone1, :phone2)
    end
    def set_member_params
      params.require(:member).permit(name:[], birth:[], sex:[], indentifycard:[], phone1:[], phone2:[])
    end
end
