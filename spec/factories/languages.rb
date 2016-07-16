FactoryGirl.define do
  factory :language do
    sequence(:name)  { |n| "Issue #{n}" }
  end
end
