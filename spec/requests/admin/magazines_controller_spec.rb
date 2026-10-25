require "rails_helper"

describe "Admin/Magazine" do

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:magazine) { FactoryBot.create(:magazine) }
  let(:new_magazine) do
    {
      issue: 3,
      volumn: 'new_magazine_volumn',
      published_at: '2026-01-01',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'test.jpg'))
    }
  end

  describe "before login" do
    describe "#index" do
      it "redirect" do
        get "/admin/magazines/"
        expect(response).to be_redirect
      end
    end

    describe "#new" do
      it "redirect" do
        get "/admin/magazines/new"
        expect(response).to be_redirect
      end
    end

    describe "#edit" do
      it "redirect" do
        get "/admin/magazines/#{magazine.id}/edit"
        expect(response).to be_redirect
      end
    end

    describe "#create" do
      it "redirect" do
        post "/admin/magazines", params: { magazine: new_magazine }
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        magazine
        update_data = { volumn: "new_volumn" }
        put "/admin/magazines/#{magazine.id}", params: { magazine: update_data }
        expect(response).to be_redirect
      end
    end

    describe "#destroy" do
      it "redirect" do
        magazine
        expect {
          delete "/admin/magazines/#{magazine.id}"
        }.to change { Magazine.count }.by(0)
        expect(response).to be_redirect
      end
    end
  end

  describe "after login" do
    before { sign_in(user) }
    after { sign_out }

    describe "#index" do
      it "redirect" do
        get "/admin/magazines/"
        expect(response).to be_redirect
      end
    end

    describe "#new" do
      it "redirect" do
        get "/admin/magazines/new"
        expect(response).to be_redirect
      end
    end

    describe "#edit" do
      it "redirect" do
        get "/admin/magazines/#{magazine.id}/edit"
        expect(response).to be_redirect
      end
    end

    describe "#create" do
      it "redirect" do
        post "/admin/magazines", params: { magazine: new_magazine }
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        magazine
        update_data = { volumn: "new_volumn" }
        put "/admin/magazines/#{magazine.id}", params: { magazine: update_data }
        expect(response).to be_redirect
      end
    end

    describe "#destroy" do
      it "redirect" do
        magazine
        expect {
          delete "/admin/magazines/#{magazine.id}"
        }.to change { Magazine.count }.by(0)
        expect(response).to be_redirect
      end
    end
  end

  describe "after login admin" do
    before { sign_in(admin) }
    after { sign_out }

    describe "#index" do
      it "success" do
        get "/admin/magazines/"
        expect(response).to be_successful
      end
    end

    describe "#new" do
      it "success" do
        get "/admin/magazines/new"
        expect(response).to be_successful
      end
    end

    describe "#edit" do
      it "success" do
        get "/admin/magazines/#{magazine.id}/edit"
        expect(response).to be_successful
      end
    end

    describe "#create" do
      it "success" do
        expect {
          post "/admin/magazines", params: { magazine: new_magazine }
        }.to change { Magazine.count }.by(1)
        expect(response).to redirect_to(admin_magazines_url)
      end

      it "shows the form again without a publish date" do
        expect {
          post "/admin/magazines", params: { magazine: new_magazine.except(:published_at) }
        }.not_to change { Magazine.count }
        expect(response).to be_successful
        expect(response.body).to include("請填寫出版日期")
      end
    end

    describe "#update" do
      it "success" do
        magazine
        update_data = { volumn: "new_volumn" }
        put "/admin/magazines/#{magazine.id}", params: { magazine: update_data }
        expect(response).to be_redirect
        expect(magazine.reload.volumn).to eq("new_volumn")
      end

      it "shows the form again when the issue is cleared" do
        put "/admin/magazines/#{magazine.id}", params: { magazine: { issue: "" } }
        expect(response).to be_successful
        expect(response.body).to include("請填寫雜誌期數")
        expect(magazine.reload.issue).to be_present
      end
    end

    describe "#destroy" do
      it "success" do
        magazine
        expect {
          delete "/admin/magazines/#{magazine.id}"
        }.to change { Magazine.count }.by(-1)
        expect(response).to be_redirect
      end
    end
  end
end