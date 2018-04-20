class TranheadsinvsController < ApplicationController
  before_action :set_tranhead, only: [:show, :edit, :update, :destroy]

  # GET /tranheads
  # GET /tranheads.json
  def index
    @tranhead = Tranheads::Sinv.all
  end

  # GET /tranheads/1
  # GET /tranheads/1.json
  def show
  end

  # DELETE /tranheads/1
  # DELETE /tranheads/1.json
  def destroy


    @tranhead.destroy

    respond_to do |format|
      format.html { redirect_to tranheadsinvs_url, notice: 'Tranhead was successfully destroyed.' }
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
      params.require(:tranhead).permit(:trref, :trdate, :bank_id, :trtype, :type, tranopnoms_attributes: [:trdetails, :tramount, :id, :nominal_id, :supplier_id, :vat_id, :vatperc, :vatamount, :netamount, :type], tranopsups_attributes: [:trdetails, :tramount, :id, :supplier_id, :type], tranopdisbs_attributes: [:trdetails, :tramount, :id, :case_id, :type])
    end


end
