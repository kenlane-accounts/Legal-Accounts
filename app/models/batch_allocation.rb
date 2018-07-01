class BatchAllocation
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :receipt_tran_id, :allocations_attributes

  def initialize(attributes = {})
    self.allocations_attributes = {}
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    # send("payments=", payments_attributes)
    if allocations_attributes.any?
      @allocations = []
      self.allocations_attributes.each do |i, p|
        @allocations.push Allocation.new(p)
      end
    end
    # @payments ||= []
    # if payments_attributes
    #   payments_attributes.each do |i, a|
    #     @payments.push ClaimItemPayment.find a[:claim_item_payment_id]
    #   end
    # end
  end

  def persisted?
    false
  end


  def receipt_tran
    @receipt_tran ||= Tranormat.find(receipt_tran_id)
  end

  def allocations
    @allocations ||= Transimat.includes(:tranhead).where('tranheads.case_id = ?', @receipt_tran.case_id).references(:tranheads).map do |invoice_tran|
      Allocation.new receipt_tran_id: receipt_tran_id, invoice_tran_id: invoice_tran.id
    end
  end
end
