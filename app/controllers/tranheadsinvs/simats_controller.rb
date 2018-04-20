class Tranheadsinvs::SimatsController < ApplicationController
    before_action :set_tranhead, only: [:edit, :update, :destroy]
  
  def new
    @i=0
    @tranhead = Tranheads::Sinv.new
    @tranhead.trans << Transimat.new
  end
  
  def create
    @tranhead = Tranhead.new(tranhead_params)
    respond_to do |format|

      if @tranhead.save
        format.html { redirect_to tranheadsinvs_path, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @tranhead }
      else
        format.html { render :new }
        format.json { render json: @tranhead.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @tranhead.update(tranhead_params)
        format.html { redirect_to tranheadsinvs_path, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @tranhead }
      else
        format.html { render :edit }
        format.json { render json: @tranhead.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tranhead
      @tranhead = Tranhead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tranhead_params
      params.require(:tranheads_sinv).permit(:trref, :trdate, :case_id, :type, 
        trans_attributes: [:id, :nominal_id, :trdetails, :netamount, :vat_id, :vatperc, :vatamount, :outamount, :tramount, :case_id, :nominal_id, :type, :_destroy])

    end
end
