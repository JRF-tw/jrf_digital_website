FactoryBot.define do
  factory :issue_column do
    magazine { FactoryBot.create(:magazine) }
    column { FactoryBot.create(:column) }
    sequence(:page) { |n| n }
    sequence(:name) { |n| "Issue Column #{n}" }
  end
end
