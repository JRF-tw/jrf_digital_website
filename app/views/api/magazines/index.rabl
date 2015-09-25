object @magazines
node(:count) { |_| @magazines_count }
child(:@magazines) do
  attributes :name, :volumn, :issue, :published_at
  node :image do |m|
    "#{Setting.url.protocol}://#{Setting.url.host}/images/covers/#{m.issue}.jpg"
  end
  node :pdf do |m|
    "#{Setting.url.protocol}://#{Setting.url.host}/magazines/#{m.issue}.pdf"
  end
end
node(:status) {"success"}
