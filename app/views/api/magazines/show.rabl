object @magazine
child(:@magazine) do
  attributes :name, :volumn, :issue, :pdf, :published_at
  node :image do |m|
    "#{Setting.url.protocol}://#{Setting.url.host}/images/covers/#{m.issue}.jpg"
  end
  node :pdf do |m|
    "#{Setting.url.protocol}://#{Setting.url.host}/magazines/#{m.issue}.pdf"
  end
  child(:articles) do
    attributes :id, :title, :author, :page, :content, :comment
    child(:column) do
      attributes :id, :name
    end
  end
end
node(:status) {"success"}