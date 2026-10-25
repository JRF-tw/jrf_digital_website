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

  describe "#index as JSON" do
    it "lists records and filters by keyword" do
      wanted = FactoryBot.create(:record, title: "司法改革紀錄甲")
      FactoryBot.create(:record, title: "其他紀錄乙")
      get "/records.json", params: { query: "紀錄甲" }
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["records"].map { |r| r["identifier"] }).to eq([wanted.identifier])
    end

    it "leaves sensitive records out" do
      open_record = FactoryBot.create(:record, sensitive: false, title: "公開紀錄")
      sensitive = FactoryBot.create(:record, sensitive: true, title: "敏感紀錄")
      get "/records.json"
      body = JSON.parse(response.body)
      expect(body["records"].map { |r| r["identifier"] }).to eq([open_record.identifier])
      get "/records.json", params: { query: "紀錄" }
      body = JSON.parse(response.body)
      expect(body["records"].map { |r| r["identifier"] }).not_to include(sensitive.identifier)
    end
  end

  describe "#show" do
    it "success" do
      get "/records/#{record.identifier}"
      expect(response).to be_successful
    end

    it "counts the visit" do
      expect { get "/records/#{record.identifier}" }.to change { record.reload.visits }.by(1)
    end

    it "raises not found (served as 404) for an unknown record" do
      expect { get "/records/no-such-record" }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "hides the download link of an unpublished file from the public" do
      hidden = FactoryBot.create(:record, published: false, pdf: "https://example.com/hidden.pdf")
      get "/records/#{hidden.identifier}"
      expect(response.body).not_to include("hidden.pdf")
    end

    it "shows the download link of an unpublished file to an admin" do
      hidden = FactoryBot.create(:record, published: false, pdf: "https://example.com/hidden.pdf")
      sign_in(FactoryBot.create(:admin))
      get "/records/#{hidden.identifier}"
      expect(response.body).to include("hidden.pdf")
    end

    it "shows the download link of a published file" do
      shown = FactoryBot.create(:record, published: true, pdf: "https://example.com/shown.pdf")
      get "/records/#{shown.identifier}"
      expect(response.body).to include("shown.pdf")
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
