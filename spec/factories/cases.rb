FactoryBot.define do
  factory :case do
    company_id 1
    sequence(:reference) { |n| "case_ref#{n}" }
    description 'some case'
    client
    casestatus
  end

  factory :casestatus do
    sequence(:code) { |n| "casestatus#{n}"}
  end
end