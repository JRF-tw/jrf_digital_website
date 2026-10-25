require "rails_helper"

# The normal login flow already signs non-admins out, so this puts a non-admin
# session in place directly to exercise Admin::BaseController#require_admin.
describe "Admin access" do
  include Warden::Test::Helpers
  after { Warden.test_reset! }

  %w[/admin/records /admin/magazines /admin/articles /admin/users].each do |path|
    it "signs a non-admin out of #{path}" do
      login_as(FactoryBot.create(:user), scope: :user)
      get path
      expect(response).to redirect_to("/")
      get path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "sends a visitor on #{path} to the login page" do
      get path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  it "doesn't let a non-admin promote themselves" do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    put "/admin/users/#{user.id}", params: { user: { admin: 1 } }
    expect(user.reload.admin).to be_falsey
  end
end
