class Allocation < ActiveRecord::Base
  belongs_to :receipt_tran, class_name: 'Tranormat', required: true
  belongs_to :invoice_tran, class_name: 'Transimat', required: true

  validates_numericality_of :amount

  validate :numericality_of_amount
  validate :billing_receipt
  validate :matching_of_cases

  before_create :calculate_vat

  before_destroy do
    unless can_delete?
      false
    end
  end

  def can_delete?
    return false unless persisted?
    Allocation.where('invoice_tran_id = :invoice_tran_id and created_at > :created_at', invoice_tran_id: invoice_tran_id, created_at: created_at).count == 0
  end

  private

  def numericality_of_amount
    if amount.blank?
      errors.add :amount, 'should not be blank'
      return
    end

    unless amount >= 0.01
      errors.add :amount, 'should be greater than or equal to 0.01'
    end

    if invoice_tran && (amount > invoice_tran.to_alloc)
      errors.add :amount, 'should be less than or equal to invoice total'
    end
    if receipt_tran && (amount > receipt_tran.to_alloc)
      errors.add :amount, 'should be less than or equal to receipt total'
    end
  end

  def billing_receipt
    unless receipt_tran.try(:troutlaybill) == 'Billing'
      errors.add :receipt_tran_id, "Receipt Transaction must be of type 'Billing'"
    end
  end

  def matching_of_cases
    if invoice_tran && (receipt_tran.try(:case_id) != invoice_tran.tranhead.try(:case_id))
      errors.add :receipt_tran_id, "Receipt Transaction case_id does not match Invoice case_id"
    end
  end

  def calculate_vat
    not_alloc_out = (invoice_tran.outamount || 0) - invoice_tran.allocated
    not_alloc_out = not_alloc_out < 0 ? 0.0 : not_alloc_out

    vatable_amount = invoice_tran.outamount.nil? ? amount : amount - not_alloc_out
    vatable_amount = vatable_amount < 0 ? 0.0 : vatable_amount
    self.vat = vatable_amount - (vatable_amount * 100.0 / (100 + invoice_tran.vatperc))
  end
end
