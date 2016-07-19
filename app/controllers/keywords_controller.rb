class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /keywords
  def index
    @q = Keyword.search(params[:q])
    @keywords = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "關鍵字列表",
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: "關鍵字列表"
      }
    })
  end

  # GET /keywords/1
  def show
    @records = @keyword.records.includes(:subjects).page params[:page]
    set_meta_tags({
      title: "關鍵字 #{@keyword.name}",
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: "關鍵字 #{@keyword.name}"
      }
    })
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
