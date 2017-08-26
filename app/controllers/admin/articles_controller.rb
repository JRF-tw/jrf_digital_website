class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, except: [:index, :new, :sort]

  # GET /articles
  def index
    if params[:m]
      @articles = Article.includes(issue_column: [:magazine, :column]).ransack({issue_column_magazine_issue_eq: params[:m]}).
        result(distinct: true).order(id: :asc).page(params[:page]).per(10)
    else
      @articles = Article.includes(issue_column: [:magazine, :column]).order(id: :asc).page(params[:page]).per(10)
    end
    set_meta_tags({
      title: "文章管理",
      og: {
        title: "文章管理"
      }
    })
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    set_meta_tags({
      title: "新增文章",
      og: {
        title: "新增文章"
      }
    })
  end

  # GET /articles/1/edit
  def edit
    set_meta_tags({
      title: "編輯文章",
      og: {
        title: "編輯文章"
      }
    })
  end

  # POST /articles
  def create
    if @article.save
      redirect_to admin_articles_url, notice: '文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to admin_articles_url, notice: '文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
    redirect_to admin_articles_url, notice: '文章已刪除'
  end

  def sort
    article_params[:order].each do |key,value|
      Article.find(value[:id]).update_attribute(:position, value[:position])
    end
    render body: nil
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = params[:id] ? Article.find(params[:id]) : Article.new(article_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:image, :image_cache, :remove_image, :title, :author, :page, :content, :comment, 
      :is_cover, :published_at, :issue_column_id)
  end
end
