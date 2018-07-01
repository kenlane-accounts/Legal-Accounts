FactoryBot.define do
  factory :vat do
    sequence(:vatcode) { |n| "vat#{n}" }
    vatperc 12.0
  end
end