FactoryBot.define do
  factory :allocation do
    amount 9.99
    vat 9.99
    receipt_tran
    invoice_tran

    after(:build) { |allocation|
      allocation.receipt_tran.case_id = allocation.invoice_tran.tranhead.case_id
    }
  end
end
