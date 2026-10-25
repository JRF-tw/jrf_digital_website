class IssueColumn < ApplicationRecord
  has_many :articles
  belongs_to :magazine
  belongs_to :column
  scope :page_order, -> { order("page ASC") }

  # Ransack allow-lists (see Record for rationale).
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[magazine column]
  end
  before_save :update_name

  def update_name
    self.name = "#{magazine.name} #{column.name}"
  end
end
