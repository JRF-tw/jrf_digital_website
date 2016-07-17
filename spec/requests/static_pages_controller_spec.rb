require "rails_helper"

describe "Static Pages" do

  describe "#home" do
    it "success" do
      2.times { FactoryGirl.create :record }
      2.times { FactoryGirl.create :article }
      get "/"
      expect(response).to be_success
    end
  end

  describe "#about" do
    it "success" do
      get "/about"
      expect(response).to be_success
    end
  end

  describe "#sitemap" do
    it "success" do
      2.times { FactoryGirl.create :record }
      2.times { FactoryGirl.create :article }
      get "/sitemap.xml"
      expect(response).to be_success
    end
  end
end