class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :identifier
      t.integer :category_id
      t.integer :carrier_id
      t.integer :pattern_id
      t.integer :issue_id
      t.integer :language_id
      t.integer :collector_id
      t.boolean :sensitive, default: false
      t.string :title
      t.string :contributor
      t.string :publisher
      t.date :date
      t.string :unit
      t.string :size
      t.string :page
      t.string :quantity
      t.string :subject
      t.text :catalog
      t.text :content
      t.string :information
      t.text :comment
      t.string :copyright
      t.string :right_in_rem
      t.string :ownership
      t.boolean :published, default: true
      t.string :licence
      t.string :filename
      t.string :filetype
      t.string :creator
      t.date :created_at
      t.string :commentor
      t.date :commented_at
      t.string :updater
      t.date :updated_at
    end
    add_index :records, :identifier, unique: true
  end
end