require "rails_helper"
require "tmpdir"

# Admins upload pictures/documents through the Redactor editor; only the
# configured file types may be stored under public/system.
describe "Redactor upload types" do
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
end
