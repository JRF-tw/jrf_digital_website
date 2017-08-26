class Admin::RecordsController < Admin::BaseController
  before_action :set_record, except: [:index, :new, :sort]

  # GET /records
  def index
    @records = Record.includes(:category, :carrier).order(identifier: :asc).page(params[:page])
    set_meta_tags({
      title: "典藏記錄管理",
      og: {
        title: "典藏記錄管理"
      }
    })
  end

  # GET /records/1
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
    set_meta_tags({
      title: "新增典藏記錄",
      og: {
        title: "新增典藏記錄"
      }
    })
  end

  # GET /records/1/edit
  def edit
    set_meta_tags({
      title: "編輯典藏記錄",
      og: {
        title: "編輯典藏記錄"
      }
    })
  end

  # POST /records
  def create
    if @record.save
      redirect_to admin_records_url, notice: '典藏記錄建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /records/1
  def update
    if @record.update(record_params)
      redirect_to admin_records_url, notice: '典藏記錄更新成功'
    else
      render :edit
    end
  end

  # DELETE /records/1
  def destroy
    @record.destroy
    redirect_to admin_records_url, notice: '典藏記錄已刪除'
  end

  def sort
    record_params[:order].each do |key,value|
      Record.find(value[:id]).update_attribute(:position, value[:position])
    end
    render body: nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_record
    @record = params[:id] ? Record.friendly.find(params[:id]) : Record.new(record_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit(:identifier, :category_id, :carrier_id, :pattern_id, :issue_id, :language_id, :collector_id,
      :sensitive, :title, :contributor, :publisher, :date, :unit,:size, :page, :quantity, :catalog, :content, :information,
      :comment, :copyright, :right_in_rem, :ownership, :published, :license, :filename, :filetype, :creator, :created_at,
      :commentor, :commented_at, :updater, :updated_at, :image, :image_cache, :remove_image, :visits, :statistics, :serial_no)
  end
end
