class AddSlugToRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :records, :pdf, :string
    add_column :records, :slug, :string, uniq: true
    add_index :records, :slug, unique: true
  end
end
