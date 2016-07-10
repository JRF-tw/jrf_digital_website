class IssueColumn < ActiveRecord::Base
  has_many :articles
  belongs_to :magazine
  belongs_to :column
  scope :page_order, -> { order("page ASC") }
  before_save :update_name

  def update_name
    self.name = "#{magazine.name} #{column.name}"
  end
end
