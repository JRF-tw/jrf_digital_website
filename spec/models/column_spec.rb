require 'spec_helper'

describe Column do
  let(:column) {FactoryGirl.create(:column)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :column
    }.to change { Column.count }.by(1)
  end
end