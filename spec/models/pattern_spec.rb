require 'spec_helper'

describe Pattern do
  let(:pattern) {FactoryBot.create(:pattern)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :pattern
    }.to change { Pattern.count }.by(1)
  end
end