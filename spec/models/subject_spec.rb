require 'spec_helper'

describe Subject do
  let(:subject) {FactoryGirl.create(:subject)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_article_creat_success" do
    expect {
      FactoryGirl.create :article_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_propaganda_creat_success" do
    expect {
      FactoryGirl.create :propaganda_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_document_creat_success" do
    expect {
      FactoryGirl.create :document_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_statement_creat_success" do
    expect {
      FactoryGirl.create :statement_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_petition_creat_success" do
    expect {
      FactoryGirl.create :petition_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_affair_creat_success" do
    expect {
      FactoryGirl.create :affair_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_letter_creat_success" do
    expect {
      FactoryGirl.create :letter_subject
    }.to change { Subject.count }.by(1)
  end
end