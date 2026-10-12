require "rails_helper"

describe "Admin/User" do

  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }

  describe "before login" do
    describe "#index" do
      it "redirect" do
        get "/admin/users/"
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        user
        update_data = { admin: 1 }
        put "/admin/users/#{user.id}", params: { user: update_data }
        expect(response).to be_redirect
      end
    end
  end

  describe "after login" do
    before { sign_in(user) }
    after { sign_out }

    describe "#index" do
      it "redirect" do
        get "/admin/users/"
        expect(response).to be_redirect
      end
    end

    describe "#update" do
      it "redirect" do
        user
        update_data = { admin: 1 }
        put "/admin/users/#{user.id}", params: { user: update_data }
        expect(response).to be_redirect
      end
    end
  end

  describe "after login admin" do
    before { sign_in(admin) }
    after { sign_out }

    describe "#index" do
      it "success" do
        user
        get "/admin/users/"
        expect(response).to be_successful
        expect(response.body).to include(user.email)
      end

      it "search by email" do
        user
        get "/admin/users/", params: { q: { name_or_email_cont: user.email } }
        expect(response.body).to include(user.email)
        expect(response.body).not_to include(admin.email)
      end
    end

    describe "#update" do
      it "success" do
        user
        update_data = { admin: 1 }
        put "/admin/users/#{user.id}", params: { user: update_data }
        expect(response).to be_redirect
        user.reload
        expect(user.admin).to eq(true)
      end

      it "can't change self" do
        put "/admin/users/#{admin.id}", params: { user: { admin: 0 } }
        expect(admin.reload.admin).to eq(true)
      end
    end

    describe "#destroy" do
      it "success" do
        user
        expect { delete "/admin/users/#{user.id}" }.to change { User.count }.by(-1)
      end

      it "can't delete self" do
        expect { delete "/admin/users/#{admin.id}" }.not_to change { User.count }
      end
    end
  end
end