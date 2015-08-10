class Record < ActiveRecord::Base
  has_and_belongs_to_many :keywords, -> { uniq }
  belongs_to :carrier
  belongs_to :category
  belongs_to :collector
  belongs_to :issue
  belongs_to :language
  belongs_to :pattern

  scope :query_keywords, -> (query) {
    select("records.*").
    joins('LEFT OUTER JOIN "keywords_records" ON "keywords_records"."record_id" = "records"."id"
      LEFT OUTER JOIN "keywords" ON "keywords_records"."keyword_id" = "keywords"."id"').
    where("keywords.name LIKE ?", query).
    group("records.id")
  }
end
