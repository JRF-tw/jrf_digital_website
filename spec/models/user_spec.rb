require "rails_helper"

describe User do
  let(:user) {FactoryBot.create(:user)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :user
    }.to change { User.count }.by(1)
  end

  it "#factory_creat_admin_success" do
    expect {
      FactoryBot.create :admin
    }.to change { User.count }.by(1)
  end
end