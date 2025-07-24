require 'spec_helper'

describe Issue do
  let(:issue) {FactoryBot.create(:issue)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :issue
    }.to change { Issue.count }.by(1)
  end
end