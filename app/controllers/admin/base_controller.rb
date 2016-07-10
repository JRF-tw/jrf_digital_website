class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_action :require_admin

  private

  def require_admin
    unless current_user.admin?
      sign_out current_user
      redirect_to '/'
    end
  end

end