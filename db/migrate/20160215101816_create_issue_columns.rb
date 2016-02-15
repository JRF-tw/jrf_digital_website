class CreateIssueColumns < ActiveRecord::Migration
  def change
    create_table :issue_columns do |t|
      t.references :magazine, null: false
      t.references :column, null: false
      t.integer :page, default: 0
    end
    add_index(:issue_columns, [:magazine_id, :column_id], name: "issue_columns_index", unique: true)
  end
end
