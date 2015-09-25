object @article
child(:@article) do
  attributes :id, :title, :author, :page, :content, :comment
  child(:magazine) do
    attributes :name, :volumn, :issue, :published_at
    node :image do |m|
      "#{Setting.url.protocol}://#{Setting.url.host}/images/covers/#{m.issue}.jpg"
    end
    node :pdf do |m|
      "#{Setting.url.protocol}://#{Setting.url.host}/magazines/#{m.issue}.pdf"
    end
  end
  child(:column) do
    attributes :id, :name
  end
end
node(:status) {"success"}