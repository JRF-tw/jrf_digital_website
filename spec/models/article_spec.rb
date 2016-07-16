require 'spec_helper'

describe Article do
  let(:article) {FactoryGirl.create(:article)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :article
    }.to change { Article.count }.by(1)
  end
end