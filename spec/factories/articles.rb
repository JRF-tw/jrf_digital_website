FactoryBot.define do
  factory :article do
    sequence(:title)  { |n| "Article #{n}" }
    sequence(:content) { |n| "Article_#{n} Content"}
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'test.jpg')) }
    sequence(:comment) { |n| "Article_#{n} Comment"}
    sequence(:author) { |n| "Article_#{n} Author"}
    sequence(:page) { |n| n }
    is_cover { false }
    sequence(:created_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:updated_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:published_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    issue_column { FactoryBot.create(:issue_column) }
  end
end
