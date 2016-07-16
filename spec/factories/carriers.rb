FactoryGirl.define do
  factory :carrier do
    sequence(:name)  { |n| "Carrier #{n}" }
  end
end
