class Article < ApplicationRecord
  has_and_belongs_to_many :keywords, index: { unique: true }
  delegate :magazine, to: :issue_column, allow_nil: true
  delegate :column, to: :issue_column, allow_nil: true
  belongs_to :issue_column
  mount_uploader :image, ImageUploader
  paginates_per 12

  # Ransack allow-lists (see Record for rationale).
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[issue_column keywords]
  end

  scope :magazine_order , -> { includes(issue_column: [:magazine]).order("magazines.published_at DESC, articles.page ASC") }
  scope :page_order, -> { order("page ASC") }
  scope :cover_articles , -> { where(is_cover: true) }
  scope :not_cover_articles , -> { where(is_cover: false) }
  scope :column_articles, -> (column) { where(column_id: column.id) }
end
