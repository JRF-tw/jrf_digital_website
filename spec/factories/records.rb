require "uuidtools"

FactoryGirl.define do
  factory :record do
    identifier { UUIDTools::UUID.timestamp_create.to_s }
    carrier { FactoryGirl.create(:carrier) }
    pattern { FactoryGirl.create(:pattern) }
    issue { FactoryGirl.create(:issue) }
    language { FactoryGirl.create(:language) }
    collector { FactoryGirl.create(:collector) }
    keywords {[ FactoryGirl.create(:keyword) ]}
    subjects {[ FactoryGirl.create(:subject) ]}
    sequence(:title)  { |n| "Record #{n} Title" }
    sequence(:contributor) { |n| "Record_#{n} Contributor"}
    sensitive false
    sequence(:publisher) { |n| "Record_#{n} Publisher"}
    sequence(:date) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:unit)  { |n| "Record #{n} Unit" }
    sequence(:size)  { |n| "Record #{n} Size" }
    sequence(:page)  { |n| n }
    sequence(:quantity)  { |n| n }
    sequence(:catalog)  { |n| "Record #{n} Catalog" }
    sequence(:content)  { |n| "Record #{n} Content" }
    sequence(:information)  { |n| "Record #{n} Information" }
    sequence(:comment)  { |n| "Record #{n} Comment" }
    sequence(:copyright)  { |n| "Record #{n} Copyright" }
    sequence(:right_in_rem)  { |n| "Record #{n} Right in Rem" }
    sequence(:ownership)  { |n| "Record #{n} Ownership" }
    published true
    sequence(:license)  { |n| "Record #{n} License" }
    sequence(:filename)  { |n| "Record #{n} Filename" }
    sequence(:filetype)  { |n| "Record #{n} Filetype" }
    sequence(:creator)  { |n| "Record #{n} Creator" }
    sequence(:created_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:commentor)  { |n| "Record #{n} Commentor" }
    sequence(:commented_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:updater)  { |n| "Record #{n} Updater" }
    sequence(:updated_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    image "/images/backgrounds/102.jpg"
    sequence(:serial_no)  { |n| "Record #{n} Serial No" }
  end
end
