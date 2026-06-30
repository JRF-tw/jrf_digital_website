module ApplicationHelper
  def default_meta_tags
    if Setting.url.protocol == 'http'
      canonical_url = request.url
    else
      canonical_url = request.url.sub(/^http:\/\//, "#{Setting.url.protocol}://")
    end
    {
      separator: "&nbsp;&mdash;&nbsp;".html_safe,
      site: '數位典藏檢索系統 – 民間司法改革基金會',
      reverse: true,
      description: '收錄民間司法改革基金會歷年聲明文件、剪報、會務資訊、以及其他數位內容。',
      canonical: canonical_url,
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

  # Schema.org Article structured data (JSON-LD) for an archive record. Improves
  # how search engines understand the page and its eligibility for rich results.
  def record_json_ld(record)
    image = record.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}#{assets_path('jrf.jpg')}" : record.image
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
      "author" => { "@type" => "Organization", "name" => "財團法人民間司法改革基金會" },
      "publisher" => {
        "@type" => "Organization",
        "name" => "財團法人民間司法改革基金會",
        "logo" => { "@type" => "ImageObject", "url" => "#{Setting.url.protocol}://#{Setting.url.host}#{assets_path('jrf.jpg')}" }
      },
      "mainEntityOfPage" => { "@type" => "WebPage", "@id" => record_url(record) }
    }
    # json_escape turns <, > and & into their \uXXXX form so record content can't
    # break out of the <script> tag (XSS-safe), then mark the result html_safe.
    content_tag(:script, json_escape(data.to_json).html_safe, type: "application/ld+json")
  end
end
