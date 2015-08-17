class Magazine < ActiveRecord::Base
  has_many :articles
  has_many :columns, through: :articles
  before_save :update_name
  mount_uploader :image, ImageUploader
  default_scope { order(published_at: :desc) }
  validates_presence_of :issue, message: '請填寫雜誌期數'
  validates_presence_of :published_at, message: '請填寫出版日期'

  def update_name
    self.name = "司改雜誌第#{self.issue}期"
  end
end
