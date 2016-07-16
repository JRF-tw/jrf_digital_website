base_url = "#{Setting.url.protocol}://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
 
xml.tag! 'urlset', "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
 
  xml.url do
    xml.loc "#{base_url}"
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/about"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/articles"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/propagandas"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/documents"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/statements"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/petitions"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/affairs"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/records/letters"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/magazines"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/articles"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  @records.each do |record|
    xml.url do
      xml.loc record_url(record)
      xml.lastmod record.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end
 
  @magazines.each do |magazine|
    xml.url do
      xml.loc magazine_url(magazine)
      xml.lastmod magazine.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end

  @articles.each do |article|
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end

  @keywords.each do |keyword|
    xml.url do
      xml.loc keyword_url(keyword)
      xml.lastmod Time.now.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end

  @subjects.each do |subject|
    xml.url do
      xml.loc subject_url(subject)
      xml.lastmod Time.now.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end
end
