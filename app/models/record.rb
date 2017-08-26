class Record < ApplicationRecord
  extend FriendlyId
  friendly_id :identifier, use: :slugged
  has_and_belongs_to_many :keywords, index: { unique: true }
  has_and_belongs_to_many :subjects, index: { unique: true }
  belongs_to :carrier
  belongs_to :category
  belongs_to :collector
  belongs_to :issue
  belongs_to :language
  belongs_to :pattern
  default_scope { order(identifier: :asc) }


  paginates_per 12

  scope :insensitive, -> {
    where(sensitive: false)
  }

  scope :query_keywords, -> (query) {
    select("records.*").
    joins('LEFT OUTER JOIN "keywords_records" ON "keywords_records"."record_id" = "records"."id"
      LEFT OUTER JOIN "keywords" ON "keywords_records"."keyword_id" = "keywords"."id"').
    where("keywords.name LIKE ?", query).
    group("records.id")
  }

  def full_subject
    subject_array = self.subjects.map { |s| s.name }
    subject_array.join('、')
  end
end
