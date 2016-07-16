FactoryGirl.define do
  factory :column do
    sequence(:name)  { |n| "Column #{n}" }
    sequence(:created_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:updated_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
  end
end
