# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Elements::CommentBlock do
  subject { described_class.new }

  describe ".index" do
    it "answers nil for empty lines" do
      expect(described_class.index([], "test")).to eq(0)
    end

    it "answers index for matching lines" do
      lines = ["one", "<!-- two -->", "three"]
      expect(described_class.index(lines, "two")).to eq(1)
    end

    it "answers nil for non-matching lines" do
      lines = ["one", "<!-- two -->", "three"]
      expect(described_class.index(lines, "bogus")).to eq(0)
    end
  end

  describe "#start_index" do
    subject { described_class.new start_id: "START", message: "Test" }
    let(:lines) { ["<!-- START: Test -->", "Line 1", "Line 2"] }

    it "answers start comment index" do
      expect(subject.start_index(lines)).to eq(0)
    end

    context "when comment doesn't match" do
      let(:lines) { ["<!-- START: Different -->", "Line 1", "Line 2"] }

      it "answers start comment index" do
        expect(subject.start_index(lines)).to eq(0)
      end
    end
  end

  describe "#start_tag" do
    it "answers default start comment" do
      expect(subject.start_tag).to eq("<!-- Tocer[start]: Auto-generated, don't remove. -->")
    end

    it "answers customized start comment" do
      subject = described_class.new start_id: "START", message: "Keep it secret, keep it safe."
      expect(subject.start_tag).to eq("<!-- START: Keep it secret, keep it safe. -->")
    end
  end

  describe "#finish_index" do
    let(:lines) { ["Line 1", "Line 2", "<!-- FINISH: Test -->"] }
    subject { described_class.new finish_id: "FINISH", message: "Test" }

    it "answers finish comment index" do
      expect(subject.finish_index(lines)).to eq(2)
    end

    context "when comment doesn't match" do
      let(:lines) { ["Line 1", "Line 2", "<!-- FINISH: Different -->"] }

      it "answers finish comment index" do
        expect(subject.finish_index(lines)).to eq(2)
      end
    end
  end

  describe "#finish_tag" do
    it "answers default finish comment" do
      expect(subject.finish_tag).to eq("<!-- Tocer[finish]: Auto-generated, don't remove. -->")
    end

    it "answers customized finish comment" do
      subject = described_class.new finish_id: "FINISH", message: "Wish them well."
      expect(subject.finish_tag).to eq("<!-- FINISH: Wish them well. -->")
    end
  end

  describe "#prependable?" do
    it "answers true when start and finish indexes are zero" do
      lines = ["Line 1", "Line 2"]
      expect(subject.prependable?(lines)).to eq(true)
    end

    it "answers false when start index is zero and finish index is greater than zero" do
      lines = ["<!-- Tocer[start]: Begin. -->", "<!-- Tocer[finish]: End. -->"]
      expect(subject.prependable?(lines)).to eq(false)
    end

    it "answers false when start and finish indexes are greater than zero" do
      lines = ["Test", "<!-- Tocer[start]: Begin. -->", "Example", "<!-- Tocer[finish]: End. -->"]
      expect(subject.prependable?(lines)).to eq(false)
    end
  end
end
