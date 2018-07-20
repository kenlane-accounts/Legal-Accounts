class AllocationsController < ApplicationController
  def index
    @q = Allocation.ransack(params[:q])
    @allocations = @q.result.includes(invoice_tran: [:tranhead]).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.js { render partial: 'allocation_list_modal' }
    end
  end

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

  def destroy
    @allocation = Allocation.find params[:id]
    if @allocation.destroy
      flash[:success] = "Successfully deleted"
    else
      flash[:error] = "Can not delete"
    end
    redirect_to allocations_path
  end

  private

  def batch_allocation_params
    params.require(:batch_allocation).permit :receipt_tran_id, allocations_attributes: [:receipt_tran_id, :invoice_tran_id, :amount]
  end
end
