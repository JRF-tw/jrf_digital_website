class ArticlesController < ApplicationController
  before_action :set_article, except: [:new, :index]
  #before_action :authenticate_user!, except: [:new, :index]

  # GET /articles
  def index
    @articles = @q.result(distinct: true).magazine_order.page(params[:page])
  end

  # GET /articles/1
  def show
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
