require "rails_helper"

describe "Subject" do

  let(:subject) { FactoryBot.create(:subject) }

  describe "#show" do
    it "success" do
      get "/subjects/#{subject.id}"
      expect(response).to be_successful
    end
  end
end