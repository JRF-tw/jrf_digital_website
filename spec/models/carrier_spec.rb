require 'spec_helper'

describe Carrier do
  let(:carrier) {FactoryBot.create(:carrier)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :carrier
    }.to change { Carrier.count }.by(1)
  end
end