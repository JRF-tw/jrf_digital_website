require "rails_helper"

describe "Static Pages" do

  describe "#home" do
    it "success" do
      2.times { FactoryBot.create :record }
      2.times { FactoryBot.create :article }
      get "/"
      expect(response).to be_successful
    end
  end

  describe "#about" do
    it "success" do
      get "/about"
      expect(response).to be_successful
    end
  end

  describe "#sitemap" do
    it "success" do
      2.times { FactoryBot.create :record }
      2.times { FactoryBot.create :article }
      get "/sitemap.xml"
      expect(response).to be_successful
    end

    it "leaves sensitive records out" do
      open_record = FactoryBot.create(:record, sensitive: false)
      sensitive = FactoryBot.create(:record, sensitive: true)
      get "/sitemap.xml"
      expect(response.body).to include(open_record.identifier)
      expect(response.body).not_to include(sensitive.identifier)
    end
  end
end