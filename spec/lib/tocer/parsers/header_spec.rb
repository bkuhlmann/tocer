# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Parsers::Header do
  subject { described_class.new markdown }

  describe "#prefix" do
    context "with single punctuation" do
      let(:markdown) { "# Example" }

      it "answers single punctuation" do
        expect(subject.prefix).to eq("#")
      end
    end

    context "with multiple punctuation" do
      let(:markdown) { "### Example" }

      it "answers multiple punctuation" do
        expect(subject.prefix).to eq("###")
      end
    end

    context "with no punctuation" do
      let(:markdown) { "" }

      it "answers an empty string" do
        expect(subject.prefix).to eq("")
      end
    end
  end

  describe "#content" do
    context "with a new line" do
      let(:markdown) { "# Example\n" }

      it "answers content without a new line" do
        expect(subject.content).to eq("Example")
      end
    end

    context "without a new line" do
      let(:markdown) { "# Example" }

      it "answers content without a new line" do
        expect(subject.content).to eq("Example")
      end
    end
  end
end
