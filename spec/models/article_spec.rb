require 'spec_helper'

describe Article do
  let(:article) {FactoryBot.create(:article)}

  it "#factory_creat_success" do
    expect {
      FactoryBot.create :article
    }.to change { Article.count }.by(1)
  end
end