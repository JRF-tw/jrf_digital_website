require 'spec_helper'

describe IssueColumn do
  let(:issue_column) {FactoryBot.create(:issue_column)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :issue_column
    }.to change { IssueColumn.count }.by(1)
  end
end