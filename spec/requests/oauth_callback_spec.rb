require "rails_helper"

RSpec.describe "OAuth callback", type: :request do
  around do |example|
    OmniAuth.config.test_mode = true
    example.run
  ensure
    OmniAuth.config.mock_auth.delete(:google_oauth2)
    OmniAuth.config.mock_auth.delete(:facebook)
    OmniAuth.config.test_mode = false
  end

  def mock_auth(provider, uid:, email:)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
      provider: provider.to_s, uid: uid, info: { name: "OAuth #{uid}", email: email }
    )
  end

  [:google_oauth2, :facebook].each do |provider|
    it "signs an existing #{provider} admin in and sends them to the admin" do
      admin = FactoryBot.create(:admin, provider: provider.to_s, provider_uid: "uid-1")
      mock_auth(provider, uid: "uid-1", email: admin.email)

      get "/users/auth/#{provider}/callback"
      expect(response).to redirect_to(admin_records_path)
      get admin_records_path
      expect(response).to be_successful
    end

    it "links a #{provider} login to an existing admin by email" do
      admin = FactoryBot.create(:admin)
      mock_auth(provider, uid: "uid-2", email: admin.email)

      get "/users/auth/#{provider}/callback"
      expect(response).to redirect_to(admin_records_path)
      expect(admin.reload.provider_uid).to eq("uid-2")
    end

    it "sends a #{provider} account without an email to sign-up instead of creating a user" do
      mock_auth(provider, uid: "uid-4", email: nil)

      expect { get "/users/auth/#{provider}/callback" }.not_to change { User.count }
      expect(response).to redirect_to(new_user_registration_url)
    end

    it "creates a non-admin user for an unknown #{provider} account and keeps them out" do
      mock_auth(provider, uid: "uid-3", email: "new-#{provider}@example.com")

      expect { get "/users/auth/#{provider}/callback" }.to change { User.count }.by(1)
      expect(response).to redirect_to(root_path)
      expect(User.last.admin).to be_falsey
      get admin_records_path
      expect(response).to be_redirect
    end
  end
end
