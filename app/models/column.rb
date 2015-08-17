class Column < ActiveRecord::Base
  has_many :articles
  validates_presence_of :name, message: '請填寫專欄名稱'
end
