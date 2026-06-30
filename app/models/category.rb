class Category < ApplicationRecord
  has_many :records

  # Ransack allow-lists (see Record for rationale).
  def self.ransackable_attributes(_auth = nil)
    column_names
  end

  def self.ransackable_associations(_auth = nil)
    %w[records]
  end
end
