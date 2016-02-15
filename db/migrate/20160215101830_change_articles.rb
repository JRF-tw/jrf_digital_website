class ChangeArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :magazine_id, :integer
    remove_column :articles, :column_id, :integer
    add_column :articles, :issue_column_id, :integer
  end
end
