FactoryBot.define do
  factory :collector do
    sequence(:name)  { |n| "Collector #{n}" }
  end
end
