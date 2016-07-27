require "rails_helper"

require "uuidtools"

describe "Admin/Record" do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:record) { FactoryGirl.create(:record) }
  let(:new_record) do
    {
      identifier: UUIDTools::UUID.timestamp_create.to_s,
      title: "new_record_title"
    }
  end

  describe "before login" do
    describe "#index" do
      it "redirect" do
        get "/admin/records/"
        expect(response).to be_redirect
      end
    end

    describe "#new" do
      it "redirect" do
        get "/admin/records/new"
        expect(response).to be_redirect
      end
    end

    describe "#edit" do
      it "redirect" do
        get "/admin/records/#{record.identifier}/edit"
        expect(response).to be_redirect
      end
    end

    describe "#create" do
      it "redirect" do
        post "/admin/records", record: new_record
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.identifier}", record: update_data
        expect(response).to be_redirect
      end
    end

    describe "#destroy" do
      it "redirect" do
        record
        expect {
          delete "/admin/records/#{record.identifier}"
        }.to change { Record.count }.by(0)
        expect(response).to be_redirect
      end
    end
  end

  describe "after login" do
    before { sign_in(user) }
    after { sign_out }

    describe "#index" do
      it "redirect" do
        get "/admin/records/"
        expect(response).to be_redirect
      end
    end

    describe "#new" do
      it "redirect" do
        get "/admin/records/new"
        expect(response).to be_redirect
      end
    end

    describe "#edit" do
      it "redirect" do
        get "/admin/records/#{record.identifier}/edit"
        expect(response).to be_redirect
      end
    end

    describe "#create" do
      it "redirect" do
        post "/admin/records", record: new_record
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.identifier}", record: update_data
        expect(response).to be_redirect
      end
    end

    describe "#destroy" do
      it "redirect" do
        record
        expect {
          delete "/admin/records/#{record.identifier}"
        }.to change { Record.count }.by(0)
        expect(response).to be_redirect
      end
    end
  end

  describe "after login admin" do
    before { sign_in(admin) }
    after { sign_out }

    describe "#index" do
      it "success" do
        get "/admin/records/"
        expect(response).to be_success
      end
    end

    describe "#new" do
      it "success" do
        get "/admin/records/new"
        expect(response).to be_success
      end
    end

    describe "#edit" do
      it "success" do
        get "/admin/records/#{record.id}/edit"
        expect(response).to be_success
      end
    end

    describe "#create" do
      it "success" do
        post "/admin/records", record: new_record
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "success" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.id}", record: update_data
        expect(response).to be_redirect
      end
    end

    describe "#destroy" do
      it "success" do
        record
        expect {
          delete "/admin/records/#{record.identifier}"
        }.to change { Record.count }.by(-1)
        expect(response).to be_redirect
      end
    end
  end
end