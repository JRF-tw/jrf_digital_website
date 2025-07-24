require 'spec_helper'

describe Keyword do
  let(:keyword) {FactoryBot.create(:keyword)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :keyword
    }.to change { Keyword.count }.by(1)
  end
end
