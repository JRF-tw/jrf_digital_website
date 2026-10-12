require "rails_helper"
require "uri"

RSpec.describe "OAuth login", type: :request do
  around do |example|
    original = ActionController::Base.allow_forgery_protection
    ActionController::Base.allow_forgery_protection = true
    example.run
  ensure
    ActionController::Base.allow_forgery_protection = original
  end

  { google_oauth2: "accounts.google.com", facebook: "www.facebook.com" }.each do |provider, host|
    it "allows the #{provider} POST redirect through the login page CSP" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
      policy = response.headers.fetch("Content-Security-Policy")
      form_action = policy.split(";").map(&:strip).find { |directive| directive.start_with?("form-action ") }
      sources = form_action.split.drop(1)
      expect(sources).to contain_exactly("'self'", "https://accounts.google.com", "https://www.facebook.com")

      form = Nokogiri::HTML(response.body).at_css("form[action='/users/auth/#{provider}']")
      expect(form["method"]).to eq("post")
      token = form.at_css("input[name='authenticity_token']")["value"]
      post "/users/auth/#{provider}", params: { authenticity_token: token }

      expect(response).to have_http_status(:found)
      destination = URI.parse(response.location)
      expect(destination.scheme).to eq("https")
      expect(destination.host).to eq(host)
      expect(sources).to include("#{destination.scheme}://#{destination.host}")
    end

    it "rejects a #{provider} POST without a CSRF token" do
      get new_user_session_path
      post "/users/auth/#{provider}"

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
