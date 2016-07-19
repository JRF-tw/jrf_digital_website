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
    set_meta_tags({
      title: '關於我們',
      og: {
        title: '關於我們'
      }
    })
  end

  def sitemap
    @records = Record.insensitive
    @articles = Article.all
    @magazines = Magazine.all
    @keywords = Keyword.all
    @subjects = Subject.all
  end
end
