class SubjectsController < ApplicationController
  before_action :set_subject, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /subjects
  def index
    @q = Subject.search(params[:q])
    @subjects = @q.result(distinct: true).page(params[:page])
  end

  # GET /subjects/1
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  def create
    if @subject.save
        redirect_to @subject, notice: '主題建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /subjects/1
  def update
    if @subject.update(subject_params)
      redirect_to @subject, notice: '主題更新成功'
    else
      render :edit
    end
  end

  # DELETE /subjects/1
  def destroy
    @subject.destroy
    redirect_to subjects_url, notice: '主題已刪除'
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
