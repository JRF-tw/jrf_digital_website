require 'spec_helper'

describe Collector do
  let(:collector) {FactoryBot.create(:collector)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :collector
    }.to change { Collector.count }.by(1)
  end
end