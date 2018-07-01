class Allocation < ActiveRecord::Base
  belongs_to :receipt_tran, class_name: 'Tranormat', required: true
  belongs_to :invoice_tran, class_name: 'Transimat', required: true

  validates_numericality_of :amount, greater_than: 0
  validate :billing_receipt
  validate :matching_of_cases

  private

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
