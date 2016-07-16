require 'spec_helper'

describe Pattern do
  let(:pattern) {FactoryGirl.create(:pattern)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :pattern
    }.to change { Pattern.count }.by(1)
  end
end