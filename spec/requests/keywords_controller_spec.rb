require "rails_helper"

describe "Keyword" do

  let(:keyword) { FactoryBot.create(:keyword) }

  describe "#show" do
    it "success" do
      get "/keywords/#{keyword.id}"
      expect(response).to be_successful
    end
  end
end