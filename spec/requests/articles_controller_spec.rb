require "rails_helper"

describe "Article" do

  let(:article) { FactoryBot.create(:article) }

  describe "#index" do
    it "success" do
      2.times { FactoryBot.create(:article) }
      get "/articles"
      expect(response).to be_successful
    end
  end

  describe "#show" do
    it "success" do
      get "/articles/#{article.id}"
      expect(response).to be_successful
    end
  end
end