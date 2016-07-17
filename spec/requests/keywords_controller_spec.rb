require "rails_helper"

describe "Keyword" do

  let(:keyword) { FactoryGirl.create(:keyword) }

  describe "#show" do
    it "success" do
      get "/keywords/#{keyword.id}"
      expect(response).to be_success
    end
  end
end