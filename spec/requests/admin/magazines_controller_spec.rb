require "rails_helper"

describe "Admin/Magazine" do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:magazine) { FactoryGirl.create(:magazine) }
  let(:new_magazine) do
    {
      issue: 3,
      volumn: 'new_magazine_volumn',
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
        expect(response).to be_success
      end
    end

    describe "#new" do
      it "success" do
        get "/admin/magazines/new"
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "success" do
        get "/admin/magazines/#{magazine.id}/edit"
        expect(response).to be_success
      end
    end

    describe "#create" do
      it "success" do
        post "/admin/magazines", params: { magazine: new_magazine }
        expect(response).to be_success
      end
    end

    describe "#update" do
      it "success" do
        magazine
        update_data = { volumn: "new_volumn" }
        put "/admin/magazines/#{magazine.id}", params: { magazine: update_data }
        expect(response).to be_redirect
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