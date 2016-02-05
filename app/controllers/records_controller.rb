class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :destroy, :update, :create]

  def show
    @record.visits += 1
    @record.save
    set_meta_tags({
      title: @record.title,
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: @record.title,
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
      @records = @q.result(:distinct => true).page params[:page]
    end

    set_meta_tags({
      title: '典藏列表',
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: '典藏列表',
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
