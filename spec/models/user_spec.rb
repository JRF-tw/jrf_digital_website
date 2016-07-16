require "rails_helper"

describe User do
  let(:user) {FactoryGirl.create(:user)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :user
    }.to change { User.count }.by(1)
  end

  it "#factory_creat_admin_success" do
    expect {
      FactoryGirl.create :admin
    }.to change { User.count }.by(1)
  end
end