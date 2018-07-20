FactoryBot.define do
  factory :tranhead do
    company_id 1
    trdate { Date.current }

    factory :tranhead_bank, class: 'Tranheads::Bank' do
      trref 'Office Receipt'
      bank

      after(:build) do |tranhead, evaluator|
        tranhead.trans << build(:receipt_tran, tranhead: tranhead) if tranhead.trans.empty?
      end
    end

    factory :tranhead_sinv, class: 'Tranheads::Sinv' do
      trref 'Sales Invoice'
      add_attribute(:case) { association :case }

      after(:build) do |tranhead, evaluator|
        tranhead.trans << build(:receipt_tran, tranhead: tranhead)
      end
    end
  end
end