class Column < ActiveRecord::Base
  has_many :issue_columns
  has_many :magazines, through: :issue_columns
  has_many :articles, through: :issue_columns
  validates_presence_of :name, message: '請填寫專欄名稱'
end
