FactoryGirl.define do
  factory :issue_column do
    magazine { FactoryGirl.create(:magazine) }
    column { FactoryGirl.create(:column) }
    sequence(:page) { |n| n }
    sequence(:name) { |n| "Issue Column #{n}" }
  end
end
