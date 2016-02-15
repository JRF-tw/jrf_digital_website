class IssueColumn < ActiveRecord::Base
  has_many :articles
  belongs_to :magazine
  belongs_to :column
  scope :page_order, -> { order("page ASC") }
end
