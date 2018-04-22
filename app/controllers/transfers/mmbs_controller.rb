class Transfers::MmbsController < ApplicationController
    before_action :set_transfer, only: [:edit, :update, :destroy]
  
  def new
    @transfer = Transfers::Tranmmb.new
  end
  
  def create
    @transfer = Transfer.new(transfer_params)
    respond_to do |format|

      if @transfer.save
        format.html { redirect_to transfers_path, notice: 'Transfer was successfully created.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to transfers_path, notice: 'Transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfers_tranmmb).permit(:type, :date, :reference, :amount, :fromdetails, :trantype, :fromtype, :totype, :tranhead_id, :frombank_id, :todetails, :tobank_id, :fromcase_id, :tocase_id)
    end
end
