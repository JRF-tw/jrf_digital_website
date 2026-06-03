class FixArticle1743Typo < ActiveRecord::Migration[5.2]
  def up
    article = Article.find(1743)
    article.content = article.content.gsub('以狗道的方式', '以殉道的方式')
    article.save!
  end

  def down
    article = Article.find(1743)
    article.content = article.content.gsub('以殉道的方式', '以狗道的方式')
    article.save!
  end
end
