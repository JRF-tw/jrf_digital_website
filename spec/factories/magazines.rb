FactoryBot.define do
  factory :magazine do
    sequence(:issue) { |n| n }
    sequence(:volumn) { |n| n }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'test.jpg')) }
    pdf { "https://www.google.com.tw" }
    google_play { "https://www.google.com.tw" }
    sequence(:created_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:updated_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:published_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
  end
end
