require "rails_helper"

describe "Article" do

  let(:article) { FactoryGirl.create(:article) }

  describe "#index" do
    it "success" do
      2.times { FactoryGirl.create(:article) }
      get "/articles"
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "success" do
      get "/articles/#{article.id}"
      expect(response).to be_success
    end
  end
end