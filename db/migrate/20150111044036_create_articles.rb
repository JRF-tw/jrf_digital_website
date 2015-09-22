class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :magazine_id
      t.integer :column_id
      t.string :image
      t.string :title
      t.string :author
      t.integer :page
      t.text :content
      t.text :comment
      t.boolean :is_cover, default: false

      t.timestamps null: false
    end
  end
end
