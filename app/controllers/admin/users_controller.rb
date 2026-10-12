class Admin::UsersController < Admin::BaseController
  before_action :set_user, except: [:index]
  before_action :forbid_self, only: [:update, :destroy]

  # GET /users
  def index
    # Not @q: the admin header renders its record search form from @q.
    @user_q = User.ransack(params[:q])
    @users = @user_q.result(distinct: true).order(:id).page(params[:page])
    set_meta_tags({
      title: "管理員管理",
      og: {
        title: "管理員管理"
      }
    })
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to admin_users_url, notice: '使用者更新成功'
    else
      redirect_to admin_users_url, alert: '使用者更新失敗'
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: '使用者已刪除'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Don't let admins remove their own access and lock themselves out.
  def forbid_self
    redirect_to admin_users_url, alert: '不能修改或刪除自己的帳號' if @user == current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:admin)
  end
end
