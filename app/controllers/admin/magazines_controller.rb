class Admin::MagazinesController < Admin::BaseController
  before_action :set_magazine, except: [:index, :new, :sort]

  # GET /magazines
  def index
    @magazines = Magazine.order(id: :asc).page(params[:page])
    set_meta_tags({
      title: "雜誌管理",
      og: {
        title: "雜誌管理"
      }
    })
  end

  # GET /magazines/1
  def show
  end

  # GET /magazines/new
  def new
    @magazine = Magazine.new
    set_meta_tags({
      title: "新增雜誌",
      og: {
        title: "新增雜誌"
      }
    })
  end

  # GET /magazines/1/edit
  def edit
    set_meta_tags({
      title: "編輯雜誌",
      og: {
        title: "編輯雜誌"
      }
    })
  end

  # POST /magazines
  def create
    if @magazine.save
      redirect_to admin_magazines_url, notice: '雜誌建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /magazines/1
  def update
    if @magazine.update(magazine_params)
      redirect_to admin_magazines_url, notice: '雜誌更新成功'
    else
      render :edit
    end
  end

  # DELETE /magazines/1
  def destroy
    @magazine.destroy
    redirect_to admin_magazines_url, notice: '雜誌已刪除'
  end

  def sort
    magazine_params[:order].each do |key,value|
      Magazine.find(value[:id]).update_attribute(:position, value[:position])
    end
    render body: nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_magazine
    @magazine = params[:id] ? Magazine.find(params[:id]) : Magazine.new(magazine_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def magazine_params
    params.require(:magazine).permit(:name, :volumn, :image, :image_cache, :remove_image, :issue, :pdf, :google_play, :published_at)
  end
end
