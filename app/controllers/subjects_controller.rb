class SubjectsController < ApplicationController
  before_action :set_subject, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /subjects
  def index
    @q = Subject.search(params[:q])
    @subjects = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "主題列表",
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: "主題列表"
      }
    })
  end

  # GET /subjects/1
  def show
    @records = @subject.records.includes(:subjects).page params[:page]
    set_meta_tags({
      title: "主題 #{@subject.name}",
      keywords: '司法改革,數位典藏',
      og: {
        type: 'website',
        title: "主題 #{@subject.name}"
      }
    })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = params[:id] ? Subject.find(params[:id]) : Subject.new(subject_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name)
    end
end
