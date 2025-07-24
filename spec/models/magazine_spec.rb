require 'spec_helper'

describe Magazine do
  let(:magazine) {FactoryBot.create(:magazine)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :magazine
    }.to change { Magazine.count }.by(1)
  end
end