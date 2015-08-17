class Article < ActiveRecord::Base
  has_and_belongs_to_many :keywords, -> { uniq }
  belongs_to :magazine
  belongs_to :column
  mount_uploader :image, ImageUploader

  default_scope {
    includes(:magazine).
    order("magazines.published_at DESC")
  }
end
