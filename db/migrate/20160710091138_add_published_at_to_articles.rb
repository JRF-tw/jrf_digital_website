class AddPublishedAtToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :published_at, :date
    rename_column :records, :licence, :license
  end
end
