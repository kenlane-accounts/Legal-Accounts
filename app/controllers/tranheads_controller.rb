class TranheadsController < ApplicationController
  before_action :set_tranhead, only: [:show, :edit, :update, :destroy]

  # GET /tranheads
  # GET /tranheads.json
  def index
    @tranheads = Tranhead.all
  end

  # GET /tranheads/1
  # GET /tranheads/1.json
  def show
  end

  # GET /tranheads/new
  # def new()
  #   @i=0
  #   @tranhead = Tranhead.new
  #   @tranhead.trtype = params[:TranType]
  #   if params[:TranType]='N'
  #     @tranhead.tranopnoms.build
  #   end
  #   if params[:TranType]='S'
  #     @tranhead.tranopsups.build
  #   end
  # end
  
  # GET /tranheads/1/edit
  # def edit
  # end

  # POST /tranheads
  # POST /tranheads.json
  # def create
  #   @tranhead = Tranhead.new(tranhead_params)

  #   respond_to do |format|

  #     if @tranhead.save
  #       format.html { redirect_to @tranhead, notice: 'Tranhead was successfully created.' }
  #       format.json { render :show, status: :created, location: @tranhead }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @tranhead.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /tranheads/1
  # PATCH/PUT /tranheads/1.json
  # def update
  #   respond_to do |format|
  #     if @tranhead.update(tranhead_params)
  #       format.html { redirect_to @tranhead, notice: 'Tranhead was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @tranhead }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @tranhead.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /tranheads/1
  # DELETE /tranheads/1.json
  def destroy


    @tranhead.destroy

    respond_to do |format|
      format.html { redirect_to tranheads_url, notice: 'Tranhead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tranhead
      @tranhead = Tranhead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tranhead_params
      params.require(:tranhead).permit(:trref, :trdate, :bank_id, :trtype, tranopnoms_attributes: [:trdetails, :tramount, :id, :nominal_id, :supplier_id, :vat_id, :vatperc, :vatamount, :netamount, :type], tranopsups_attributes: [:trdetails, :tramount, :id, :supplier_id, :type])
    end

end
