class Api::MagazinesController < ApplicationController
  respond_to :json

  swagger_controller :magazines, 'Magazines'

  swagger_api :index do
    summary '雜誌列表'
    notes '回應、查詢雜誌列表'
    param :query, :query, :string, :optional, "查詢標題、內容或作者"
    param :query, :limit, :integer, :optional, "一次顯示多少筆"
    param :query, :offset, :integer, :optional, "從第幾筆開始顯示"
    param :query, :date_start, :string, :optional, "顯示哪個日期以後的雜誌"
    param :query, :date_end, :string, :optional, "顯示哪個日期以前的雜誌"
    response :ok, "Success", :APIMagazineIndex
  end

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

  swagger_api :show do
    summary '單一雜誌'
    notes '回應單一雜誌，與雜誌內文資訊。'
    param :path, :id, :integer, :optional, "雜誌 Id"
    response :ok, "Success", :APIMagazineShow
    response :not_found
  end

  def show
    @magazine = Magazine.includes(articles: :column).find(params[:id])
    respond_with(@magazine)
  end

  swagger_model :APIMagazineIndex do
    description "Article show structure"
    property :count, :integer, :required, "雜誌數"
    property :magazines, :array, :required, "雜誌列表", items: { '$ref' => :Magazines }
    property :status, :string, :required, "狀態"
  end

  swagger_model :APIMagazineShow do
    description "Article show structure"
    property :magazine, :array, :required, "雜誌", items: { '$ref' => :MagazineWithArticles }
    property :status, :string, :required, "狀態"
  end

  swagger_model :Magazines do
    property :magazines, :array, :required, '雜誌清單', items: { '$ref' => :Magazine }
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

  swagger_model :MagazineWithArticles do
    description "雜誌"
    property :id, :integer, :required, "雜誌 Id"
    property :name, :string, :required, "雜誌期數名稱"
    property :volumn, :string, :optional, "Volumn"
    property :image, :string, :required, "圖片網址"
    property :issue, :integer, :required, "雜誌期數"
    property :pdf, :string, :required, "PDF 下載網址"
    property :published_at, :date, :required, "雜誌發行日期"
    property :articles, :array, :required, "雜誌所屬文章", items: { '$ref' => :ArticlesWithoutMagazine }
  end

  swagger_model :ArticlesWithoutMagazine do
    property :articles, :array, :required, '文章清單', items: { '$ref' => :ArticleWithoutMagazine }
  end

  swagger_model :ArticleWithoutMagazine do
    description "文章"
    property :id, :integer, :required, "文章 Id"
    property :title, :string, :required, "標題"
    property :author, :string, :required, "作者"
    property :content, :string, :required, "內文"
    property :page, :integer, :required, "頁數"
    property :comment, :string, :optional, "註釋"
    property :column, :array, :required, "專欄", items: { '$ref' => :Column }
  end
end