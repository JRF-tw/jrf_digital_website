module ApplicationHelper
  def default_meta_tags
    {
      separator: "&mdash;".html_safe,
      site: '民間司改會數位典藏',
      reverse: true,
      description: ' ',
      og: {
        title: '民間司改會數位典藏',
        description: '收錄民間司法改革基金會歷年聲明文件、剪報、會務資訊、以及其他數位內容。',
        type: 'website',
        image: "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf.jpg",
        site_name: '民間司改會數位典藏'
      }
    }
  end
end
