FactoryBot.define do
  factory :client do
    company_id 1
    firstname 'Homer'
    middlename 'J.'
    lastname 'Simpson'
    clientstatus
  end

  factory :clientstatus do
    sequence(:code) { |n| "clientstatus#{n}"}
  end
end