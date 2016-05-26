class MagazinesController < ApplicationController
  before_action :set_magazine, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /magazines
  def index
    @magazines = Magazine.all.page(params[:page])
    set_meta_tags({
      title: "雜誌列表",
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: "雜誌列表",
        description: ''
      }
    })
  end

  # GET /magazines/1
  def show
    @articles = @magazine.articles.page_order.all
    set_meta_tags({
      title: "司法改革雜誌第 #{@magazine.issue} 期",
      description: '',
      keywords: '',
      og: {
        type: 'website',
        title: "司法改革雜誌第 #{@magazine.issue} 期",
        description: ''
      }
    })
    
  end

  # GET /magazines/new
  def new
    @magazine = Magazine.new
  end

  # GET /magazines/1/edit
  def edit
  end

  # POST /magazines
  def create
    if @magazine.save
        redirect_to @magazine, notice: '雜誌建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /magazines/1
  def update
    if @magazine.update(magazine_params)
      redirect_to @magazine, notice: '雜誌更新成功'
    else
      render :edit
    end
  end

  # DELETE /magazines/1
  def destroy
    @magazine.destroy
    redirect_to magazines_url, notice: '雜誌已刪除'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_magazine
      @magazine = params[:id] ? Magazine.includes([issue_columns: :column]).find(params[:id]) : Magazine.new(magazine_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def magazine_params
      params.require(:magazine).permit(:volumn, :issue, :published_at, :name)
    end
end
