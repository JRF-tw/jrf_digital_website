class CreateKeywordsRecords < ActiveRecord::Migration[4.2]
  def change
    create_table :keywords_records do |t|
      t.belongs_to :keyword
      t.belongs_to :record
    end
    add_index :keywords_records, [:keyword_id, :record_id], :unique => true
  end
end
