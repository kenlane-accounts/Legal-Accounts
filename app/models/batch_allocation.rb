class BatchAllocation
  include ActiveModel::Conversion
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :receipt_tran_id, :allocations_attributes

  validates_presence_of :receipt_tran_id
  validate :presence_of_allocations
  validate :validity_of_allocations

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

  def save
    allocations.delete_if{ |a| a.amount.blank? }

    if valid?
      allocations.each do |a|
        a.save
      end
      true
    else
      false
    end
  end

  def persisted?
    false
  end


  def receipt_tran
    @receipt_tran ||= Tranormat.find_by(id: receipt_tran_id)
  end

  def allocations
    @allocations ||= if receipt_tran
                       Transimat.includes(:tranhead).where('tranheads.case_id = ?', receipt_tran.case_id).references(:tranheads).map do |invoice_tran|
                         Allocation.new receipt_tran_id: receipt_tran_id, invoice_tran_id: invoice_tran.id
                       end
                     else
                       []
                     end
  end

  private

  def presence_of_allocations
    if receipt_tran && allocations.empty?
      errors.add :base, 'There is no not allocated sales invoices'
    end
  end

  def validity_of_allocations
    allocations.each do |a|
      unless a.valid?
        errors.add :base, 'Allocation amount is not valid'
        return
      end
    end
  end
end
