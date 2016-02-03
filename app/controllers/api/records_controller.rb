class Api::RecordsController < ApplicationController
  respond_to :json

  swagger_controller :records, 'Records'

  swagger_api :index do
    summary '記錄列表'
    notes '回應、查詢記錄列表資訊'
    param :query, :query, :string, :optional, "查詢標題、內容或作者"
    param :query, :limit, :integer, :optional, "一次顯示多少筆"
    param :query, :offset, :integer, :optional, "從第幾筆開始顯示"
    param :query, :date_start, :string, :optional, "顯示哪個日期以後的記錄"
    param :query, :date_end, :string, :optional, "顯示哪個日期以前的記錄"
    response :ok, "Success", :APIRecordIndex
  end

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:title_or_content_cont] = params[:query] if params[:query]
    ransack_params[:date_gt] = params[:date_start] if params[:date_start]
    ransack_params[:date_lt] = params[:date_end] if params[:date_end]
    if ransack_params.blank?
      @records = Record.includes(:category).offset(params[:offset]).limit(limit)
      @records_count = Record.count
    else
      @records = Record.includes(:category).ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @records_count = Record.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@records, @records_count)
  end

  swagger_api :show do
    summary '單一記錄'
    notes '回應單一記錄資訊'
    param :path, :id, :integer, :optional, "記錄 Id"
    response :ok, "Success", :APIRecordShow
    response :not_found
  end

  def show
    @record = Record.includes(:category, :carrier, :pattern, :issue, :language, :collector).find(params[:id])
    respond_with(@record)
  end

  swagger_model :APIRecordIndex do
    description "Article show structure"
    property :count, :integer, :required, "記錄數"
    property :records, :array, :required, "記錄列表", items: { '$ref' => :Record }
    property :status, :string, :required, "狀態"
  end

  swagger_model :APIRecordShow do
    description "Article show structure"
    property :record, nil, :required, "記錄", '$ref' => :Record
    property :status, :string, :required, "狀態"
  end

  swagger_model :Record do
    description "記錄"
    property :id, :integer, :required, "記錄 Id"
    property :identifier, :string, :required, "唯一識別碼"
    property :sensitive, :boolean, :required, "是否具有敏感性"
    property :title, :string, :required, "標題"
    property :contributor, :string, :required, "貢獻者"
    property :publisher, :string, :required, "發佈者"
    property :date, :date, :required, "日期"
    property :unit, :string, :required, "單位"
    property :size, :string, :required, "大小"
    property :page, :string, :required, "頁碼"
    property :quantity, :string, :required, "數量"
    property :catalog, :string, :required, "目錄"
    property :content, :string, :required, "內文"
    property :information, :string, :required, "資訊"
    property :comment, :string, :required, "註解"
    property :copyright, :string, :required, "著作權"
    property :right_in_rem, :string, :required, "所有權"
    property :ownership, :string, :required, "擁有者"
    property :licence, :string, :required, "授權"
    property :filename, :string, :required, "檔名"
    property :filetype, :string, :required, "檔案種類"
    property :creator, :string, :required, "建立者"
    property :created_at, :date, :required, "建立日期"
    property :commentor, :string, :required, "註解者"
    property :commented_at, :date, :required, "註解日期"
    property :updater, :string, :required, "更新者"
    property :updated_at, :date, :required, "更新日期"
    property :category, nil, :required, "分類", '$ref' => :Category
    property :carrier, nil, :required, "載體", '$ref' => :Carrier
    property :pattern, nil, :required, "記錄型別", '$ref' => :Pattern
    property :issue, nil, :required, "議題", '$ref' => :Issue
    property :language, nil, :required, "語言", '$ref' => :Language
    property :collector, nil, :required, "收集者", '$ref' => :Collector
  end

  swagger_model :Category do
    description "分類"
    property :id, :integer, :required, "分類 Id"
    property :name, :string, :required, "分類名稱"
  end

  swagger_model :Carrier do
    description "載體"
    property :id, :integer, :required, "載體 Id"
    property :name, :string, :required, "載體名稱"
  end

  swagger_model :Pattern do
    description "記錄型別"
    property :id, :integer, :required, "型別 Id"
    property :name, :string, :required, "型別名稱"
  end

  swagger_model :Issue do
    description "議題"
    property :id, :integer, :required, "議題 Id"
    property :name, :string, :required, "議題名稱"
  end

  swagger_model :Language do
    description "語言"
    property :id, :integer, :required, "語言 Id"
    property :name, :string, :required, "語言名稱"
  end

  swagger_model :Collector do
    description "收集者"
    property :id, :integer, :required, "收集者 Id"
    property :name, :string, :required, "收集者名稱"
  end
end
