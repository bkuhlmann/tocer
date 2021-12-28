# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Elements::CommentBlock do
  subject(:comment_block) { described_class.new }

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

  describe "#comments" do
    it "answers code comments only" do
      expect(comment_block.comments).to eq(<<~COMMENTS)
        <!-- Tocer[start]: Auto-generated, don't remove. -->
        <!-- Tocer[finish]: Auto-generated, don't remove. -->
      COMMENTS
    end
  end

  describe "#start_index" do
    subject(:comment_block) { described_class.new start_id: "START", message: "Test" }

    let(:lines) { ["<!-- START: Test -->", "Line 1", "Line 2"] }

    it "answers start comment index" do
      expect(comment_block.start_index(lines)).to eq(0)
    end

    context "when comment doesn't match" do
      let(:lines) { ["<!-- START: Different -->", "Line 1", "Line 2"] }

      it "answers start comment index" do
        expect(comment_block.start_index(lines)).to eq(0)
      end
    end
  end

  describe "#start_tag" do
    it "answers default start comment" do
      expect(comment_block.start_tag).to eq("<!-- Tocer[start]: Auto-generated, don't remove. -->")
    end

    it "answers customized start comment" do
      comment_block = described_class.new start_id: "START", message: "Placeholder."
      expect(comment_block.start_tag).to eq("<!-- START: Placeholder. -->")
    end
  end

  describe "#finish_index" do
    subject(:comment_block) { described_class.new finish_id: "FINISH", message: "Test" }

    let(:lines) { ["Line 1", "Line 2", "<!-- FINISH: Test -->"] }

    it "answers finish comment index" do
      expect(comment_block.finish_index(lines)).to eq(2)
    end

    context "when comment doesn't match" do
      let(:lines) { ["Line 1", "Line 2", "<!-- FINISH: Different -->"] }

      it "answers finish comment index" do
        expect(comment_block.finish_index(lines)).to eq(2)
      end
    end
  end

  describe "#finish_tag" do
    it "answers default finish comment" do
      tag = "<!-- Tocer[finish]: Auto-generated, don't remove. -->"
      expect(comment_block.finish_tag).to eq(tag)
    end

    it "answers customized finish comment" do
      comment_block = described_class.new finish_id: "FINISH", message: "Placeholder."
      expect(comment_block.finish_tag).to eq("<!-- FINISH: Placeholder. -->")
    end
  end

  describe "#empty?" do
    it "answers true when lines don't exist between start and finish index" do
      lines = ["<!-- Tocer[start]: Begin. -->", "<!-- Tocer[finish]: End. -->"]
      expect(comment_block.empty?(lines)).to eq(true)
    end

    it "answers false when lines exist between start and finish indexes" do
      lines = ["<!-- Tocer[start]: Begin. -->", "Example", "<!-- Tocer[finish]: End. -->"]
      expect(comment_block.empty?(lines)).to eq(false)
    end
  end

  describe "#prependable?" do
    it "answers true when start and finish indexes are zero" do
      lines = ["Line 1", "Line 2"]
      expect(comment_block.prependable?(lines)).to eq(true)
    end

    it "answers false when start index is zero and finish index is greater than zero" do
      lines = ["<!-- Tocer[start]: Begin. -->", "<!-- Tocer[finish]: End. -->"]
      expect(comment_block.prependable?(lines)).to eq(false)
    end

    it "answers false when start and finish indexes are greater than zero" do
      lines = ["Test", "<!-- Tocer[start]: Begin. -->", "Example", "<!-- Tocer[finish]: End. -->"]
      expect(comment_block.prependable?(lines)).to eq(false)
    end
  end
end
