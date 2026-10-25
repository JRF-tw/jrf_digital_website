require "rails_helper"

describe "API" do
  let(:article) { FactoryBot.create(:article) }
  let(:magazine) { article.magazine }

  def json
    JSON.parse(response.body)
  end

  describe "articles" do
    it "lists articles with their magazine and column" do
      article
      get "/api/articles.json"
      expect(response).to be_successful
      item = json["articles"].first
      expect(item["title"]).to eq(article.title)
      expect(item["magazine"]["issue"]).to eq(magazine.issue)
      expect(item["column"]["name"]).to eq(article.column.name)
    end

    it "filters by magazine publish date" do
      article
      get "/api/articles.json", params: { date_start: magazine.published_at - 1.day }
      expect(json["count"]).to eq(1)
      get "/api/articles.json", params: { date_start: magazine.published_at + 1.day }
      expect(json["count"]).to eq(0)
    end

    it "shows one article" do
      get "/api/articles/#{article.id}.json"
      expect(response).to be_successful
      expect(json["article"]["magazine"]["issue"]).to eq(magazine.issue)
    end
  end

  describe "records" do
    it "lists records and filters by keyword" do
      wanted = FactoryBot.create(:record, title: "司法改革紀錄甲")
      FactoryBot.create(:record, title: "其他紀錄乙")
      get "/api/records.json"
      expect(response).to be_successful
      expect(json["count"]).to eq(2)
      get "/api/records.json", params: { query: "紀錄甲" }
      expect(json["records"].map { |r| r["identifier"] }).to eq([wanted.identifier])
    end

    it "leaves sensitive records out" do
      open_record = FactoryBot.create(:record, sensitive: false, title: "公開紀錄")
      sensitive = FactoryBot.create(:record, sensitive: true, title: "敏感紀錄")
      get "/api/records.json"
      expect(json["count"]).to eq(1)
      expect(json["records"].map { |r| r["identifier"] }).to eq([open_record.identifier])
      get "/api/records.json", params: { query: "紀錄" }
      expect(json["records"].map { |r| r["identifier"] }).not_to include(sensitive.identifier)
    end

    it "doesn't show a sensitive record" do
      sensitive = FactoryBot.create(:record, sensitive: true)
      expect { get "/api/records/#{sensitive.id}.json" }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "shows one record" do
      record = FactoryBot.create(:record)
      get "/api/records/#{record.id}.json"
      expect(response).to be_successful
      expect(json["record"]["identifier"]).to eq(record.identifier)
    end
  end

  describe "magazines" do
    it "lists magazines" do
      magazine
      get "/api/magazines.json"
      expect(response).to be_successful
      expect(json["count"]).to eq(1)
    end

    it "shows one magazine with its articles" do
      get "/api/magazines/#{magazine.id}.json"
      expect(response).to be_successful
      expect(json["magazine"]["articles"].first["column"]["name"]).to eq(article.column.name)
    end
  end
end
