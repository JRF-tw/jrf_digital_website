FactoryGirl.define do
  factory :issue do
    sequence(:name)  { |n| "Issue #{n}" }
  end
end
