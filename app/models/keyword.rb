class Keyword < ApplicationRecord
  has_and_belongs_to_many :records, index: { unique: true }
  has_and_belongs_to_many :articles, index: { unique: true }
end
