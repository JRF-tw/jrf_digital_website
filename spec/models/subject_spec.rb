require 'spec_helper'

describe Subject do
  let(:subject) {FactoryBot.create(:subject)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_article_creat_success" do
    expect {
      FactoryBot.create :article_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_propaganda_creat_success" do
    expect {
      FactoryBot.create :propaganda_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_document_creat_success" do
    expect {
      FactoryBot.create :document_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_statement_creat_success" do
    expect {
      FactoryBot.create :statement_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_petition_creat_success" do
    expect {
      FactoryBot.create :petition_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_affair_creat_success" do
    expect {
      FactoryBot.create :affair_subject
    }.to change { Subject.count }.by(1)
  end

  it "#factory_letter_creat_success" do
    expect {
      FactoryBot.create :letter_subject
    }.to change { Subject.count }.by(1)
  end
end