require "rails_helper"

describe ApplicationHelper, type: :helper do
  describe "#display_shorter" do
    it "returns short text as plain text" do
      expect(helper.display_shorter("<p>司法改革</p>", 10)).to eq("司法改革")
    end

    it "cuts long text to the display width and adds an ellipsis" do
      result = helper.display_shorter("<p>#{'司法改革' * 20}</p>", 10)
      expect(result).to end_with("⋯⋯")
      expect(result).not_to include("<p>")
      expect(Unicode::DisplayWidth.of(result)).to be <= 20
    end
  end
end
