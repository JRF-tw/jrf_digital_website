class Article < ActiveRecord::Base
  has_and_belongs_to_many :keywords, -> { uniq }
  delegate :magazine, to: :issue_column, allow_nil: true
  delegate :column, to: :issue_column, allow_nil: true
  belongs_to :issue_column
  mount_uploader :image, ImageUploader
  paginates_per 12

  scope :magazine_order , -> { includes(issue_column: [:magazine]).order("magazines.published_at DESC, articles.page ASC") }
  scope :page_order, -> { order("page ASC") }
  scope :cover_articles , -> { where(is_cover: true) }
  scope :not_cover_articles , -> { where(is_cover: false) }
  scope :column_articles, -> (column) { where(column_id: column.id) }
end
