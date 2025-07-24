require "rails_helper"

describe "Magazine" do

  let(:magazine) { FactoryBot.create(:magazine) }

  describe "#index" do
    it "success" do
      2.times { FactoryBot.create(:magazine) }
      get "/magazines"
      expect(response).to be_successful
    end
  end

  describe "#show" do
    it "success" do
      get "/magazines/#{magazine.id}"
      expect(response).to be_successful
    end
  end
end