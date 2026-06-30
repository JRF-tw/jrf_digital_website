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

  # Ransack allow-lists: restrict searchable/sortable surface to this model's own
  # columns and its (non-sensitive) content associations, so crafted `q[...]`
  # params can't traverse to unexpected tables. Also required by Ransack >= 4.
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[keywords subjects carrier category collector issue language pattern]
  end

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
    subject_array = subjects.map { |s| s.name }
    subject_array.join('、')
  end
end
