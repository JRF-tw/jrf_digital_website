module ApplicationHelper
  def default_meta_tags
    canonical_url = canonical_url_for_request
    {
      separator: "&nbsp;&mdash;&nbsp;".html_safe,
      site: '數位典藏檢索系統 – 民間司法改革基金會',
      reverse: true,
      description: '收錄民間司法改革基金會歷年聲明文件、剪報、會務資訊、以及其他數位內容。',
      canonical: canonical_url,
      # Search results are endless parameter combinations; keep them out of the
      # index but let crawlers follow their links to the records.
      noindex: search_results_page?,
      follow: search_results_page?,
      publisher: Setting.google.pages,
      og: {
        title: '民間司改會數位典藏',
        description: '收錄民間司法改革基金會歷年聲明文件、剪報、會務資訊、以及其他數位內容。',
        type: 'website',
        image: "#{Setting.url.protocol}://#{Setting.url.host}#{assets_path('jrf.jpg')}",
        site_name: '民間司改會數位典藏',
        url: canonical_url
      },
      twitter: {
        card: 'summary_large_image',
        image: "#{Setting.url.protocol}://#{Setting.url.host}#{assets_path('jrf.jpg')}"
      },
      fb: {
        pages: Setting.fb.pages
      }
    }
  end

  def display_shorter(str, length, additional = "⋯⋯")
    length = length * 2
    text = Nokogiri::HTML(str).text
    if Unicode::DisplayWidth.of(text) >= length
      additional_text = Nokogiri::HTML(additional).text
      new_length = length - Unicode::DisplayWidth.of(additional_text)
      short_string = text[0..new_length]
      while Unicode::DisplayWidth.of(short_string) > new_length
        short_string = short_string[0..-2]
      end
      short_string + additional
    else
      text
    end
  end

  def assets_path(resource)
    ActionController::Base.helpers.asset_path(resource)
  end

  # Absolute URL on the public site for a path (or pass an absolute URL through).
  # og:image and JSON-LD need absolute URLs.
  def site_url(path)
    path = path.to_s
    return path if path.start_with?('http://', 'https://')
    "#{Setting.url.protocol}://#{Setting.url.host}#{path}"
  end

  # The page URL without tracking or search parameters (only pagination is a
  # distinct page), on the site's public protocol.
  def canonical_url_for_request
    url = "#{request.base_url}#{request.path}"
    url = url.sub(/\Ahttps?:\/\//, "#{Setting.url.protocol}://")
    page = params[:page].to_i
    page > 1 ? "#{url}?page=#{page}" : url
  end

  def search_results_page?
    q = params[:q]
    q = q.to_unsafe_h.values if q.respond_to?(:to_unsafe_h)
    Array(q).any?(&:present?) || params[:query].present?
  end

  # Schema.org Article structured data (JSON-LD) for an archive record. Improves
  # how search engines understand the page and its eligibility for rich results.
  def record_json_ld(record)
    image = site_url(record.image.blank? ? assets_path('jrf.jpg') : record.image)
    data = {
      "@context" => "https://schema.org",
      "@type" => "Article",
      "headline" => record.title,
      "description" => display_shorter(record.content.to_s, 150),
      "identifier" => record.identifier,
      "inLanguage" => "zh-TW",
      "datePublished" => (record.date || record.created_at)&.iso8601,
      "dateModified" => record.updated_at&.iso8601,
      "image" => image,
      "author" => jrf_organization,
      "publisher" => jrf_organization,
      "mainEntityOfPage" => { "@type" => "WebPage", "@id" => record_url(record) }
    }
    json_ld_tag(data)
  end

  # Schema.org Article for a magazine article.
  def article_json_ld(article)
    data = {
      "@context" => "https://schema.org",
      "@type" => "Article",
      "headline" => article.title,
      "description" => display_shorter(article.content.to_s, 150),
      "inLanguage" => "zh-TW",
      "datePublished" => (article.published_at || article.created_at)&.iso8601,
      "dateModified" => article.updated_at&.iso8601,
      "image" => site_url(article.image.blank? ? assets_path('jrf.jpg') : article.image.url),
      "author" => article.author.present? ? { "@type" => "Person", "name" => article.author } : jrf_organization,
      "publisher" => jrf_organization,
      "isPartOf" => article.magazine && { "@type" => "PublicationIssue", "name" => article.magazine.name, "issueNumber" => article.magazine.issue.to_s },
      "mainEntityOfPage" => { "@type" => "WebPage", "@id" => article_url(article) }
    }.compact
    json_ld_tag(data)
  end

  # Home page: site name and the organization behind it, used by Google for the
  # site name shown in results.
  def site_json_ld
    data = {
      "@context" => "https://schema.org",
      "@graph" => [
        { "@type" => "WebSite", "name" => "民間司改會數位典藏", "alternateName" => "數位典藏檢索系統",
          "url" => site_url("/"), "inLanguage" => "zh-TW", "publisher" => jrf_organization },
        jrf_organization.merge("url" => "https://www.jrf.org.tw/", "sameAs" => [Setting.url.fb].compact)
      ]
    }
    json_ld_tag(data)
  end

  def jrf_organization
    { "@type" => "Organization", "name" => "財團法人民間司法改革基金會",
      "logo" => { "@type" => "ImageObject", "url" => site_url(assets_path('jrf.jpg')) } }
  end

  # json_escape turns <, > and & into their \uXXXX form so page content can't
  # break out of the <script> tag (XSS-safe), then mark the result html_safe.
  def json_ld_tag(data)
    content_tag(:script, json_escape(data.to_json).html_safe, type: "application/ld+json")
  end
end
