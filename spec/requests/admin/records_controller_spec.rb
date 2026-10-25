require "rails_helper"

require "uuidtools"

describe "Admin/Record" do

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:record) { FactoryBot.create(:record) }
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
        post "/admin/records", params: { record: new_record }
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.identifier}", params: { record: update_data }
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

    describe "#show" do
      it "redirect" do
        get "/admin/records/#{record.identifier}"
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
        post "/admin/records", params: { record: new_record }
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.identifier}", params: { record: update_data }
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
        expect(response).to be_successful
      end
    end

    describe "#show" do
      it "success" do
        get "/admin/records/#{record.identifier}"
        expect(response).to be_successful
      end
    end

    describe "#new" do
      it "success" do
        get "/admin/records/new"
        expect(response).to be_successful
      end
    end

    describe "#edit" do
      it "success" do
        get "/admin/records/#{record.id}/edit"
        expect(response).to be_successful
      end

      it "offers subjects, not keywords, in the subject picker" do
        subject_record = FactoryBot.create(:subject, name: "主題選項")
        keyword = FactoryBot.create(:keyword, name: "關鍵字選項")
        get "/admin/records/#{record.id}/edit"
        picker = Nokogiri::HTML(response.body).at_css("#subjects-field")
        expect(picker.css("option").map(&:text)).to include(subject_record.name)
        expect(picker.css("option").map(&:text)).not_to include(keyword.name)
      end
    end

    describe "#create" do
      it "success" do
        post "/admin/records", params: { record: new_record }
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "success" do
        record
        update_data = { title: "new_title" }
        put "/admin/records/#{record.id}", params: { record: update_data }
        expect(response).to be_redirect
      end

      it "saves keywords and subjects" do
        keywords = FactoryBot.create_list(:keyword, 2)
        subjects = FactoryBot.create_list(:subject, 2)
        put "/admin/records/#{record.id}", params: { record: {
          keyword_ids: [""] + keywords.map(&:id), subject_ids: [""] + subjects.map(&:id) } }
        expect(record.reload.keywords).to match_array(keywords)
        expect(record.subjects).to match_array(subjects)
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