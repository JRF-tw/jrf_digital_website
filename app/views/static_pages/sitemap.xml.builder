base_url = "#{Setting.url.protocol}://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'

# Google ignores changefreq/priority and only trusts lastmod when it's accurate,
# so lastmod is given only where the real update time is known.
xml.tag! 'urlset', "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  ['', '/about', '/records', '/records/articles', '/records/propagandas', '/records/documents',
   '/records/statements', '/records/petitions', '/records/affairs', '/records/letters',
   '/magazines', '/articles'].each do |path|
    xml.url { xml.loc "#{base_url}#{path}" }
  end

  (@records.to_a + @magazines.to_a + @articles.to_a).each do |item|
    xml.url do
      xml.loc polymorphic_url(item)
      xml.lastmod item.updated_at.iso8601
    end
  end

  (@keywords.to_a + @subjects.to_a).each do |item|
    xml.url { xml.loc polymorphic_url(item) }
  end
end
