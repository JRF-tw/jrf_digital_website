class AddPublishedAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :published_at, :date
    rename_column :records, :licence, :license
  end
end
