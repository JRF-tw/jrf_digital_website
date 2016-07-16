class StaticPagesController < ApplicationController
  def home
    @records = Record.includes(:subjects).order(visits: :desc).first(3)
    set_meta_tags({
      title: '首頁',
      og: {
        title: '首頁'
      }
    })
  end

  def about
  end

  def sitemap
    @records = Record.insensitive
    @articles = Article.all
    @magazines = Magazine.all
    @keywords = Keyword.all
    @subjects = Subject.all
  end
end
