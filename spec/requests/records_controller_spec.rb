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
      get "/records/articles"
      expect(response).to be_successful
    end
  end

  describe "#propagandas" do
    it "success" do
      get "/records/propagandas"
      expect(response).to be_successful
    end
  end

  describe "#documents" do
    it "success" do
      get "/records/documents"
      expect(response).to be_successful
    end
  end

  describe "#propagandas" do
    it "success" do
      get "/records/propagandas"
      expect(response).to be_successful
    end
  end

  describe "#statements" do
    it "success" do
      get "/records/statements"
      expect(response).to be_successful
    end
  end

  describe "#petitions" do
    it "success" do
      get "/records/petitions"
      expect(response).to be_successful
    end
  end

  describe "#affairs" do
    it "success" do
      get "/records/affairs"
      expect(response).to be_successful
    end
  end

  describe "#letters" do
    it "success" do
      get "/records/letters"
      expect(response).to be_successful
    end
  end
end
