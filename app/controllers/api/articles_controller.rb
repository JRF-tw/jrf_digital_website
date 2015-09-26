class Api::ArticlesController < ApplicationController
  respond_to :json

  swagger_controller :articles, 'Articles'

  swagger_api :index do
    summary '文章列表'
    notes '回應、查詢文章列表'
    param :query, :query, :string, :optional, "查詢標題、內容或作者"
    param :query, :limit, :integer, :optional, "一次顯示多少筆"
    param :query, :offset, :integer, :optional, "從第幾筆開始顯示"
    param :query, :date_start, :string, :optional, "顯示哪個日期以後的文章"
    param :query, :date_end, :string, :optional, "顯示哪個日期以前的文章"
    response :ok, "Success", :APIArticleIndex
  end

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

  swagger_api :show do
    summary '單一文章'
    notes '回應單一文章資訊'
    param :path, :id, :integer, :optional, "文章 Id"
    response :ok, "Success", :APIArticleShow
    response :not_found
  end

  def show
    @article = Article.includes(:magazine, :column).find(params[:id])
    respond_with(@article)
  end

  swagger_model :APIArticleIndex do
    description "Article show structure"
    property :count, :integer, :required, "文章數"
    property :articles, :array, :required, "文章列表", items: { '$ref' => :Articles }
    property :status, :string, :required, "狀態"
  end

  swagger_model :APIArticleShow do
    description "Article show structure"
    property :article, :array, :required, "文章", items: { '$ref' => :Article }
    property :status, :string, :required, "狀態"
  end

  swagger_model :Articles do
    property :articles, :array, :required, '文章清單', items: { '$ref' => :Article }
  end

  swagger_model :Article do
    description "文章"
    property :id, :integer, :required, "文章 Id"
    property :title, :string, :required, "標題"
    property :author, :string, :required, "作者"
    property :content, :string, :required, "內文"
    property :page, :integer, :required, "頁數"
    property :comment, :string, :optional, "註釋"
    property :magazine, :array, :required, "雜誌", items: { '$ref' => :Magazine }
    property :column, :array, :required, "專欄", items: { '$ref' => :Column }
  end

  swagger_model :Magazine do
    description "雜誌"
    property :id, :integer, :required, "雜誌 Id"
    property :name, :string, :required, "雜誌期數名稱"
    property :volumn, :string, :optional, "Volumn"
    property :image, :string, :required, "圖片網址"
    property :issue, :integer, :required, "雜誌期數"
    property :pdf, :string, :required, "PDF 下載網址"
    property :published_at, :date, :required, "雜誌發行日期"
  end

  swagger_model :Column do
    description "專欄"
    property :id, :integer, :required, "專欄 Id"
    property :name, :string, :required, "專欄名稱"
  end
end