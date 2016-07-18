class ArticlesController < ApplicationController
  before_action :set_article, except: [:new, :index]
  #before_action :authenticate_user!, except: [:new, :index]

  # GET /articles
  def index
    @query = params[:q] ? params[:q][:title_or_content_cont] : nil
    @articles = @q.result(distinct: true).magazine_order.page(params[:page])
    title = @query ? "搜尋結果：#{@query}" : '雜誌文章列表'
    set_meta_tags({
      title: title,
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: title
      }
    })
  end

  # GET /articles/1
  def show
    keywords = @article.keywords.to_a.map{ |k| k.name }.join(',')
    set_meta_tags({
      title: @article.title,
      description: display_shorter(@article.content, 100),
      keywords: keywords,
      og: {
        type: 'article',
        image: @article.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf.jpg" : "#{Setting.url.protocol}://#{Setting.url.host}#{@article.image}",
        title: @article.title,
        description: display_shorter(@article.content, 100)
      },
      article: {
        publisher: Setting.url.fb,
        published_time: @article.published_at.strftime('%FT%T%:z'),
        modified_time: @article.updated_at.strftime('%FT%T%:z')
      },
      twitter: {
        image: @article.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf.jpg" : "#{Setting.url.protocol}://#{Setting.url.host}#{@article.image}",
      }
    })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = params[:id] ? Article.includes(issue_column: [:magazine]).find(params[:id]) : Article.new(article_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :published_at, :comment, :issue_column_id,
        {keyword_ids: []}, :author, :comment)
    end
end
