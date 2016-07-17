require "rails_helper"

describe "Subject" do

  let(:subject) { FactoryGirl.create(:subject) }

  describe "#show" do
    it "success" do
      get "/subjects/#{subject.id}"
      expect(response).to be_success
    end
  end
end