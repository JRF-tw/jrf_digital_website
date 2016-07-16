require 'spec_helper'

describe Magazine do
  let(:magazine) {FactoryGirl.create(:magazine)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :magazine
    }.to change { Magazine.count }.by(1)
  end
end