require "rails_helper"

describe "Magazine" do

  let(:magazine) { FactoryGirl.create(:magazine) }

  describe "#index" do
    it "success" do
      2.times { FactoryGirl.create(:magazine) }
      get "/magazines"
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "success" do
      get "/magazines/#{magazine.id}"
      expect(response).to be_success
    end
  end
end