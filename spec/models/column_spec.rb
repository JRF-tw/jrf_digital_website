require 'spec_helper'

describe Column do
  let(:column) {FactoryBot.create(:column)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :column
    }.to change { Column.count }.by(1)
  end
end