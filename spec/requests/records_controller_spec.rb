require "rails_helper"

describe "Record" do

  let(:record) { FactoryBot.create(:record) }

  describe "#index" do
    it "success" do
      2.times { FactoryBot.create(:record) }
      get "/records"
      expect(response).to be_successful
    end
  end

  describe "#show" do
    it "success" do
      get "/records/#{record.identifier}"
      expect(response).to be_successful
    end
  end

  describe "#articles" do
    it "success" do
      r = FactoryBot.create(:article_record)
      get "/records/articles"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#propagandas" do
    it "success" do
      r = FactoryBot.create(:propaganda_record)
      get "/records/propagandas"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#documents" do
    it "success" do
      r = FactoryBot.create(:document_record)
      get "/records/documents"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#propagandas" do
    it "success" do
      r = FactoryBot.create(:propaganda_record)
      get "/records/propagandas"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#statements" do
    it "success" do
      r = FactoryBot.create(:statement_record)
      get "/records/statements"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#petitions" do
    it "success" do
      r = FactoryBot.create(:petition_record)
      get "/records/petitions"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#affairs" do
    it "success" do
      r = FactoryBot.create(:affair_record)
      get "/records/affairs"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end

  describe "#letters" do
    it "success" do
      r = FactoryBot.create(:letter_record)
      get "/records/letters"
      expect(response.body).to include(r.title)
      expect(response).to be_successful
    end
  end
end
