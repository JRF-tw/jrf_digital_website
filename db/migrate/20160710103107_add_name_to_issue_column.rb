class AddNameToIssueColumn < ActiveRecord::Migration
  def change
    add_column :issue_columns, :name, :string
  end
end
