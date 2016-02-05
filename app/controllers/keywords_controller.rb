class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /keywords
  def index
    @q = Keyword.search(params[:q])
    @keywords = @q.result(distinct: true).page(params[:page])
  end

  # GET /keywords/1
  def show
    @records = @keyword.records.includes(:subjects).page params[:page]
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  def create
    if @keyword.save
        redirect_to @keyword, notice: '關鍵字建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      redirect_to @keyword, notice: '關鍵字更新成功'
    else
      render :edit
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: '關鍵字已刪除'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:name)
    end
end
