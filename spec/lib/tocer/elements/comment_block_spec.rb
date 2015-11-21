require "spec_helper"

describe Tocer::Elements::CommentBlock do
  subject { described_class.new }

  describe "#start" do
    it "answers default start comment" do
      expect(subject.start).to eq("<!-- Tocer[start]: Auto-generated, don't remove. -->")
    end

    it "answers customized start comment" do
      subject = described_class.new start_id: "START", message: "Keep it secret, keep it safe."
      expect(subject.start).to eq("<!-- START: Keep it secret, keep it safe. -->")
    end
  end

  describe "#start_index" do
    subject { described_class.new start_id: "START", message: "Test" }
    let(:collection) { ["<!-- START: Test -->", "Line 1", "Line 2"] }

    it "answers start comment index" do
      expect(subject.start_index(collection)).to eq(0)
    end
  end

  describe "#finish" do
    it "answers default finish comment" do
      expect(subject.finish).to eq("<!-- Tocer[finish]: Auto-generated, don't remove. -->")
    end

    it "answers customized finish comment" do
      subject = described_class.new finish_id: "FINISH", message: "Wish them well."
      expect(subject.finish).to eq("<!-- FINISH: Wish them well. -->")
    end
  end

  describe "#finish_index" do
    subject { described_class.new finish_id: "FINISH", message: "Test" }
    let(:collection) { ["Line 1", "Line 2", "<!-- FINISH: Test -->"] }

    it "answers start comment index" do
      expect(subject.finish_index(collection)).to eq(2)
    end
  end
end
