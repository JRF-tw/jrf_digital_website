require 'spec_helper'

describe Subject do
  let(:subject) {FactoryGirl.create(:subject)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :subject
    }.to change { Subject.count }.by(1)
  end
end