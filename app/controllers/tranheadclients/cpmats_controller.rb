class Tranheadclients::CpmatsController < ApplicationController
    before_action :set_tranhead, only: [:edit, :update, :destroy]
  
  def new
    @i=0
    @tranhead = Tranheads::Bankclient.new
    @tranhead.trans << Trancpmat.new
  end
  
  def create
    @tranhead = Tranhead.new(tranhead_params)
    respond_to do |format|

      if @tranhead.save
        format.html { redirect_to tranheadclients_path, notice: 'Client payment was successfully created.' }
        format.json { render :show, status: :created, location: @tranhead }
      else
        format.html { render :new }
        format.json { render json: @tranhead.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
     @tranhead.trans.each do |item|
        item.netamount=item.netamount*-1
        item.tramount=item.tramount*-1
    end 
  end

  def update
    respond_to do |format|
      if @tranhead.update(tranhead_params)
        format.html { redirect_to tranheadclients_path, notice: 'Client payment was successfully updated.' }
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
      params.require(:tranheads_bankclient).permit(:trref, :trdate, :bank_id, :type, :askoverdraw, :overdraw, :allorig, :sumtramount, 
        trans_attributes: [:id, :trdetails, :tramount, :case_id, :type, :askclientoverdraw, :clientoverdraw, :origamount, :_destroy])

    end
end
