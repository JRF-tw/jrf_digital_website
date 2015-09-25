class Api::MagazinesController < ApplicationController
  respond_to :json

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:articles_title_or_articles_content_or_articles_author_cont] = params[:query] if params[:query]
    ransack_params[:published_at_gt] = params[:date_start] if params[:date_start]
    ransack_params[:published_at_lt] = params[:date_end] if params[:date_end]
    if ransack_params.blank?
      @magazines = Magazine.offset(params[:offset]).limit(limit)
      @magazines_count = Magazine.count
    else
      @magazines = Magazine.includes(:articles).ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @magazines_count = Magazine.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@magazines, @magazines_count)
  end

  def show
    @magazine = Magazine.includes(articles: :column).find(params[:id])
    respond_with(@magazine)
  end
end