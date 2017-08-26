class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :destroy, :update, :create]

  def show
    if @record.blank?
      not_found
    end
    @record.update_columns(visits: (@record.visits + 1))
    keywords = @record.keywords.to_a.map{ |k| k.name }.join(',')
    set_meta_tags({
      title: @record.title,
      description: display_shorter(@record.content, 150),
      keywords: keywords,
      og: {
        type: 'article',
        image: @record.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf.jpg" : @record.image,
        title: @record.title,
        description: display_shorter(@record.content, 150)
      },
      article: {
        publisher: Setting.url.fb,
        published_time: @record.created_at.strftime('%FT%T%:z'),
        modified_time: @record.updated_at.strftime('%FT%T%:z')
      },
      twitter: {
        image: @record.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf.jpg" : @record.image,
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
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: title
      }
    })

    respond_to do |format|
      format.html
      format.json {
        render json: {
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
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def propagandas
    @subject = Subject.where(name: "宣傳品").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def documents
    @subject = Subject.where(name: "公文書").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def statements
    @subject = Subject.where(name: "聲明文件").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def petitions
    @subject = Subject.where(name: "陳情相關資料").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def affairs
    @subject = Subject.where(name: "會務").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  def letters
    @subject = Subject.where(name: "信函").first
    if @subject
      @q = @subject.records.includes(:category).search(params[:q])
      @records = @q.result(distinct: true).page params[:page]
    else
      @records = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  private

  def set_record
    @record = params[:id] ? Record.friendly.find(params[:id]) : Record.new(record_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit()
  end

end
