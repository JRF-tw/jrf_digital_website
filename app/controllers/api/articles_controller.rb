class Api::ArticlesController < ApplicationController
  respond_to :json

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:title_or_content_or_author_cont] = params[:query] if params[:query]
    ransack_params[:magazine_published_at_gt] = params[:date_start] if params[:date_start]
    ransack_params[:magazine_published_at_lt] = params[:date_end] if params[:date_end]
    if ransack_params.blank?
      @articles = Article.includes(:magazine, :column).magazine_order.offset(params[:offset]).limit(limit)
      @articles_count = Article.count
    else
      @articles = Article.includes(:magazine, :column).magazine_order.ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @articles_count = Article.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@articles, @articles_count)
  end

  def show
    @article = Article.includes(:magazine, :column).find(params[:id])
    respond_with(@article)
  end
end