FactoryBot.define do
  factory :tran do
    company_id 1

    # factory :receipt_tran, class: 'Tranormat' do
    factory :tranormat, aliases: [:receipt_tran], class: 'Tranormat' do
      association :tranhead, factory: :tranhead_bank
      tramount 50.0
      troutlaybill 'Billing'
      trdetails 'some receipt'

      add_attribute(:case) { association :case }
    end

    factory :transimat, aliases: [:invoice_tran], class: 'Transimat' do
      association :tranhead, factory: :tranhead_sinv
      nominal
      trdetails 'some invoice'
      netamount 100.0
      vat
      vatamount 12.0
      outamount 10.0
      tramount 122.0
    end
  end
end
