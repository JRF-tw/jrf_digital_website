class FixArticle1743Typo < ActiveRecord::Migration[5.2]
  # Data fix for production; fresh databases (test, new dev) don't have this article.
  def up
    article = Article.find_by(id: 1743)
    return unless article
    article.content = article.content.gsub('以狗道的方式', '以殉道的方式')
    article.save!
  end

  def down
    article = Article.find_by(id: 1743)
    return unless article
    article.content = article.content.gsub('以殉道的方式', '以狗道的方式')
    article.save!
  end
end
