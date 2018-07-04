class Allocation < ActiveRecord::Base
  belongs_to :receipt_tran, class_name: 'Tranormat', required: true
  belongs_to :invoice_tran, class_name: 'Transimat', required: true

  validates_numericality_of :amount

  validate :numericality_of_amount
  validate :billing_receipt
  validate :matching_of_cases

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
end
