require 'spec_helper'

describe Collector do
  let(:collector) {FactoryGirl.create(:collector)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :collector
    }.to change { Collector.count }.by(1)
  end
end