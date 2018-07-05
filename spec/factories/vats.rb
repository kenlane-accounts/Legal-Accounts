FactoryBot.define do
  factory :vat do
    sequence(:vatcode) { |n| "vat#{n}" }
    vatperc 23.0
  end
end