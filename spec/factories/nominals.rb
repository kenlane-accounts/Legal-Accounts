FactoryBot.define do
  factory :nominal do
    code 'B'
    desc 'some nominal'

    factory :bank do
      isoffice true
    end
  end
end