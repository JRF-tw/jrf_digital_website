require 'spec_helper'

describe Language do
  let(:issue) {FactoryGirl.create(:language)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :language
    }.to change { Language.count }.by(1)
  end
end