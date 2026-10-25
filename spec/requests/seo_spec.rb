require "rails_helper"

describe "SEO" do
  def doc
    Nokogiri::HTML(response.body)
  end

  def canonical
    doc.at_css("link[rel=canonical]")["href"]
  end

  def robots
    doc.at_css("meta[name=robots]")&.[]("content")
  end

  def json_ld
    doc.css("script[type='application/ld+json']").map { |s| JSON.parse(s.text) }
  end

  describe "canonical URL" do
    it "drops tracking parameters" do
      get "/records", params: { utm_source: "fb", fbclid: "abc" }
      expect(canonical).to end_with("/records")
    end

    it "keeps the page number after the first page" do
      get "/records", params: { page: 2 }
      expect(canonical).to end_with("/records?page=2")
      get "/records", params: { page: 1 }
      expect(canonical).to end_with("/records")
    end
  end

  describe "search results" do
    it "are kept out of the index but followed" do
      get "/records", params: { q: { title_or_content_cont: "司法" } }
      expect(robots).to include("noindex").and include("follow")
    end

    it "an empty search or a plain list stays indexable" do
      get "/records", params: { q: { title_or_content_cont: "" } }
      expect(robots.to_s).not_to include("noindex")
      get "/records"
      expect(robots.to_s).not_to include("noindex")
    end
  end

  describe "structured data" do
    it "describes the site and organization on the home page" do
      get "/"
      types = json_ld.flat_map { |d| d["@graph"] || [d] }.map { |d| d["@type"] }
      expect(types).to include("WebSite", "Organization")
    end

    it "marks a magazine article as an Article" do
      article = FactoryBot.create(:article, author: "作者甲")
      get "/articles/#{article.id}"
      data = json_ld.find { |d| d["@type"] == "Article" }
      expect(data["headline"]).to eq(article.title)
      expect(data["author"]["name"]).to eq("作者甲")
      expect(data["image"]).to start_with("http")
    end

    it "uses absolute image URLs for a record" do
      record = FactoryBot.create(:record, image: "/images/backgrounds/102.jpg")
      get "/records/#{record.identifier}"
      data = json_ld.find { |d| d["@type"] == "Article" }
      expect(data["image"]).to match(%r{\Ahttps?://.+/images/backgrounds/102\.jpg\z})
      expect(doc.at_css("meta[property='og:image']")["content"]).to eq(data["image"])
    end
  end

  describe "sitemap" do
    it "gives real lastmod dates only, without changefreq or priority" do
      record = FactoryBot.create(:record)
      get "/sitemap.xml"
      xml = Nokogiri::XML(response.body)
      xml.remove_namespaces!
      expect(xml.css("changefreq, priority")).to be_empty
      entry = xml.css("url").find { |u| u.at_css("loc").text.end_with?("/records/#{record.identifier}") }
      expect(entry.at_css("lastmod").text).to eq(record.updated_at.iso8601)
      home = xml.css("url").first
      expect(home.at_css("lastmod")).to be_nil
    end
  end
end
