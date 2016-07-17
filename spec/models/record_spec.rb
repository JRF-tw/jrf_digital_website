require 'spec_helper'

describe Record do
  let(:record) {FactoryGirl.create(:record)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :record
    }.to change { Record.count }.by(1)
  end

  it "#factory_article_creat_success" do
    expect {
      FactoryGirl.create :article_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_propaganda_creat_success" do
    expect {
      FactoryGirl.create :propaganda_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_document_creat_success" do
    expect {
      FactoryGirl.create :document_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_statement_creat_success" do
    expect {
      FactoryGirl.create :statement_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_petition_creat_success" do
    expect {
      FactoryGirl.create :petition_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_affair_creat_success" do
    expect {
      FactoryGirl.create :affair_record
    }.to change { Record.count }.by(1)
  end

  it "#factory_letter_creat_success" do
    expect {
      FactoryGirl.create :letter_record
    }.to change { Record.count }.by(1)
  end

end
