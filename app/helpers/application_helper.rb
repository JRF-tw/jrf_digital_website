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
    if text.display_width >= length
      additional_text = Nokogiri::HTML(additional).text
      new_length = length - additional_text.display_width
      short_string = text[0..new_length]
      while short_string.display_width > new_length
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
end
