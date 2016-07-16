require 'spec_helper'

describe Record do
  let(:record) {FactoryGirl.create(:record)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :record
    }.to change { Record.count }.by(1)
  end
end