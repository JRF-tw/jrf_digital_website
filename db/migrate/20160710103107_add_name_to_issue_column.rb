class AddNameToIssueColumn < ActiveRecord::Migration[4.2]
  def change
    add_column :issue_columns, :name, :string
  end
end
