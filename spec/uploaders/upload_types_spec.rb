require "rails_helper"
require "tmpdir"

# Admins upload covers and Redactor pictures/documents; only the configured
# file types may be stored under public/.
describe "Upload types" do
  around do |example|
    Dir.mktmpdir { |dir| @dir = dir; example.run }
  end

  def upload(name, type)
    path = File.join(@dir, name)
    File.binwrite(path, File.binread(Rails.root.join("spec/fixtures/test.jpg")))
    Rack::Test::UploadedFile.new(path.to_s, type)
  end

  it "accepts a picture" do
    picture = RedactorRails::Picture.new(data: upload("ok.jpg", "image/jpeg"))
    expect(picture).to be_valid
  end

  it "rejects a non-image file as a picture" do
    picture = RedactorRails::Picture.new(data: upload("evil.html", "text/html"))
    expect(picture).not_to be_valid
  end

  it "rejects a file type outside the document list" do
    document = RedactorRails::Document.new(data: upload("evil.exe", "application/octet-stream"))
    expect(document).not_to be_valid
  end

  it "accepts an image as an article or magazine cover" do
    expect(FactoryBot.build(:article, image: upload("cover.png", "image/png"))).to be_valid
    expect(FactoryBot.build(:magazine, image: upload("cover.jpg", "image/jpeg"))).to be_valid
  end

  it "rejects a non-image file as an article or magazine cover" do
    expect(FactoryBot.build(:article, image: upload("cover.html", "text/html"))).not_to be_valid
    expect(FactoryBot.build(:magazine, image: upload("cover.svg", "image/svg+xml"))).not_to be_valid
  end
end
