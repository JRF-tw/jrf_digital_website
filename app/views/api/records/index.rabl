object @records
node(:count) { |_| @records_count }
child(:@records) do
  attributes :id, :identifier, :sensitive, :title, :contributor, :publisher, :date, :unit, :size, :page, :quantity
  attributes :catalog, :content, :information, :comment, :copyright, :right_in_rem, :ownership, :licence, :filename
  attributes :filetype, :creator, :created_at, :commentor, :commented_at, :updater, :updated_at, :image
  child(:category) do
    attributes :id, :name
  end
  child(:carrier) do
    attributes :id, :name
  end
  child(:pattern) do
    attributes :id, :name
  end
  child(:issue) do
    attributes :id, :name
  end
  child(:language) do
    attributes :id, :name
  end
  child(:collector) do
    attributes :id, :name
  end
end
node(:status) {"success"}