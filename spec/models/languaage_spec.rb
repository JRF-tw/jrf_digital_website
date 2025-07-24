require 'spec_helper'

describe Language do
  let(:issue) {FactoryBot.create(:language)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :language
    }.to change { Language.count }.by(1)
  end
end