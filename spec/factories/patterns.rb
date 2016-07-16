FactoryGirl.define do
  factory :pattern do
    sequence(:name)  { |n| "Pattern #{n}" }
  end
end