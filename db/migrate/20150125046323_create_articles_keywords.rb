class CreateArticlesKeywords < ActiveRecord::Migration[4.2]
  def change
    create_table :articles_keywords do |t|
      t.references :article, null: false
      t.references :keyword, null: false
    end
    add_index(:articles_keywords, [:article_id, :keyword_id], name: "articles_keywords_index", unique: true)
  end
end
