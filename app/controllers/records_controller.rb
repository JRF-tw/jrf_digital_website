class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :destroy, :update, :create]

  def show
    @record.update_columns(visits: (@record.visits + 1))
    set_meta_tags({
      title: "檔案編號 #{@record.identifier}",
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: "檔案編號 #{@record.identifier}",
        description: ''
      }
    })
  end

  def index
    if params[:format] == "json"
      if params[:query]
        query = "%#{params[:query]}%"
        @records = Record.where("title LIKE ? OR catalog LIKE ? OR content LIKE ?", query, query, query)
          .limit(params[:limit]).offset(params[:offset])
        count = Record.where("title LIKE ? OR catalog LIKE ? OR content LIKE ?", query, query, query).count
      else
        @records = Record.all.limit(params[:limit]).offset(params[:offset])
        count = Record.all.count
      end
    else
      @query = params[:q] ? params[:q][:title_or_content_cont] : nil
      @records = @q.result(distinct: true).page params[:page]
    end

    title = @query ? "搜尋結果：#{@query}" : '典藏列表'

    set_meta_tags({
      title: title,
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: title,
        description: ''
      }
    })

    respond_to do |format|
      format.html
      format.json {
        render :json => {
          status: "success",
          records: filter_records(@records),
          count: count
        },
        callback: params[:callback]
      }
    end
  end

  def articles
    @subject = Subject.where(name: "文章").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def propagandas
    @subject = Subject.where(name: "宣傳品").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def documents
    @subject = Subject.where(name: "公文書").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def statements
    @subject = Subject.where(name: "聲明文件").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def petitions
    @subject = Subject.where(name: "陳情相關資料").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def affairs
    @subject = Subject.where(name: "會務").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  def letters
    @subject = Subject.where(name: "信函").first
    @q = @subject.records.includes(:category).search(params[:q])
    @records = @q.result(distinct: true).page params[:page]
  end

  private

  def set_record
    @record = params[:id] ? Record.find(params[:id]) : Record.new(record_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit()
  end

end
