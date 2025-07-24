FactoryBot.define do
  factory :subject do
    sequence(:name)  { |n| "Subject #{n}" }
  end

  factory :article_subject, class: Subject do
    name { "文章" }
  end

  factory :propaganda_subject, class: Subject do
    name { "宣傳品" }
  end

  factory :document_subject, class: Subject do
    name { "公文書" }
  end

  factory :statement_subject, class: Subject do
    name { "聲明文件" }
  end

  factory :petition_subject, class: Subject do
    name { "陳情相關資料" }
  end

  factory :affair_subject, class: Subject do
    name { "會務" }
  end

  factory :letter_subject, class: Subject do
    name { "信函" }
  end
end
