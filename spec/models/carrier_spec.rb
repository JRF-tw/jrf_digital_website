require 'spec_helper'

describe Carrier do
  let(:carrier) {FactoryGirl.create(:carrier)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :carrier
    }.to change { Carrier.count }.by(1)
  end
end