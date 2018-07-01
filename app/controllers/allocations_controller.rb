class AllocationsController < ApplicationController
  def new
    @batch_allocation = BatchAllocation.new receipt_tran_id: params[:receipt_tran_id]
    @receipt_tran = Tranormat.find params[:receipt_tran_id]
    @invoice_trans = Transimat.includes(:tranhead).where('tranheads.case_id = ?', @receipt_tran.case_id).references(:tranheads)
    render partial: 'modal'
  end
end
