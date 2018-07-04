class AllocationsController < ApplicationController
  def new
    @batch_allocation = BatchAllocation.new receipt_tran_id: params[:receipt_tran_id]
    # @receipt_tran = Tranormat.find params[:receipt_tran_id]
    # @invoice_trans = Transimat.includes(:tranhead).where('tranheads.case_id = ?', @receipt_tran.case_id).references(:tranheads)
    render partial: 'modal'
  end

  def create
    @batch_allocation = BatchAllocation.new batch_allocation_params
    @batch_allocation.save
    respond_to do |format|
      format.js
    end
  end

  private

  def batch_allocation_params
    params.require(:batch_allocation).permit :receipt_tran_id, allocations_attributes: [:receipt_tran_id, :invoice_tran_id, :amount]
  end
end
