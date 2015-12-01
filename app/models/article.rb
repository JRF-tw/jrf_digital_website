class Article < ActiveRecord::Base
  has_and_belongs_to_many :keywords, -> { uniq }
  belongs_to :magazine
  belongs_to :column
  mount_uploader :image, ImageUploader
  paginates_per 10

  scope :magazine_order , -> { includes(:magazine).order("magazines.published_at DESC, articles.page ASC") }
  scope :page_order, -> { order("page ASC") }
  scope :cover_articles , -> { where(is_cover: true) }
  scope :not_cover_articles , -> { where(is_cover: false) }
  scope :column_articles, -> (column) { where(column_id: column.id) }
end
