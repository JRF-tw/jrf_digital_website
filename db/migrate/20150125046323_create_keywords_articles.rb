class CreateKeywordsArticles < ActiveRecord::Migration
  def change
    create_table :keywords_articles do |t|
      t.references :keyword, null: false
      t.references :article, null: false
    end
    add_index(:keywords_articles, [:keyword_id, :article_id], name: "keywords_articles_index", unique: true)
  end
end
