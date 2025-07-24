require "uuidtools"

FactoryBot.define do
  factory :record do
    identifier { UUIDTools::UUID.timestamp_create.to_s }
    carrier { FactoryBot.create(:carrier) }
    pattern { FactoryBot.create(:pattern) }
    issue { FactoryBot.create(:issue) }
    language { FactoryBot.create(:language) }
    collector { FactoryBot.create(:collector) }
    keywords {[ FactoryBot.create(:keyword) ]}
    subjects {[ FactoryBot.create(:subject) ]}
    sequence(:title)  { |n| "Record #{n} Title" }
    sequence(:contributor) { |n| "Record_#{n} Contributor"}
    sensitive { false }
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
    published { true }
    sequence(:license)  { |n| "Record #{n} License" }
    sequence(:filename)  { |n| "Record #{n} Filename" }
    sequence(:filetype)  { |n| "Record #{n} Filetype" }
    sequence(:creator)  { |n| "Record #{n} Creator" }
    sequence(:created_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:commentor)  { |n| "Record #{n} Commentor" }
    sequence(:commented_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    sequence(:updater)  { |n| "Record #{n} Updater" }
    sequence(:updated_at) { |n| Date.today - ( 6 * ( (1..10).to_a[n % 10] )).days }
    image { "/images/backgrounds/102.jpg" }
    sequence(:serial_no)  { |n| "Record #{n} Serial No" }
  end

  factory :article_record, parent: :record do
    subjects {[ create_subject('文章') ]}
  end

  factory :propaganda_record, parent: :record do
    subjects {[ create_subject('宣傳品') ]}
  end

  factory :document_record, parent: :record do
    subjects {[ create_subject('公文書') ]}
  end

  factory :statement_record, parent: :record do
    subjects {[ create_subject('聲明文件') ]}
  end

  factory :petition_record, parent: :record do
    subjects {[ create_subject('陳情相關資料') ]}
  end

  factory :affair_record, parent: :record do
    subjects {[ create_subject('會務') ]}
  end

  factory :letter_record, parent: :record do
    subjects {[ create_subject('信函') ]}
  end
end
