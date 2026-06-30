class Keyword < ApplicationRecord
  has_and_belongs_to_many :records, index: { unique: true }
  has_and_belongs_to_many :articles, index: { unique: true }

  # Ransack allow-lists (see Record for rationale).
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[records articles]
  end
end
