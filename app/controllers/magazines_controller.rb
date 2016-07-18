class MagazinesController < ApplicationController
  before_action :set_magazine, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /magazines
  def index
    @magazines = Magazine.all.page(params[:page])

    set_meta_tags({
      title: '雜誌列表',
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: '雜誌列表'
      }
    })
  end

  # GET /magazines/1
  def show
    @articles = @magazine.articles.page_order.all
    set_meta_tags({
      title: "司法改革雜誌第 #{@magazine.issue} 期",
      description: "司法改革雜誌第 #{@magazine.issue} 期",
      keywords: "司法改革",
      og: {
        type: 'article',
        image: "#{Setting.url.protocol}://#{Setting.url.host}#{@magazine.image}",
        title: "司法改革雜誌第 #{@magazine.issue} 期",
        description: "司法改革雜誌第 #{@magazine.issue} 期",
      },
      article: {
        publisher: Setting.url.fb,
        published_time: @magazine.published_at.strftime('%FT%T%:z'),
        modified_time: @magazine.updated_at.strftime('%FT%T%:z')
      },
      twitter: {
        image: "#{Setting.url.protocol}://#{Setting.url.host}#{@magazine.image}",
      }
    })
    
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
