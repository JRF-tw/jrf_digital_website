class Magazine < ApplicationRecord
  has_many :issue_columns
  has_many :columns, through: :issue_columns
  has_many :articles, through: :issue_columns
  before_save :update_name
  mount_uploader :image, ImageUploader
  default_scope { order(issue: :desc) }
  validates_presence_of :issue, message: '請填寫雜誌期數'
  validates_presence_of :published_at, message: '請填寫出版日期'
  paginates_per 16

  # Ransack allow-lists (see Record for rationale).
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[issue_columns columns articles]
  end

  def update_name
    self.name = "司改雜誌第#{self.issue}期"
  end
end


