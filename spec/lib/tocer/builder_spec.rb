require "spec_helper"

describe Tocer::Builder do
  let :lines do
    [
      "# Overview\n",
      "An overview.\n",
      "# Features\n",
      "Some features.\n",
      "# History\n",
      "Some historic information.\n"
    ]
  end
  subject { described_class.new lines }

  describe "#headers" do
    context "when headers exist" do
      it "answers headers" do
        expect(subject.headers).to contain_exactly("# Overview\n", "# Features\n", "# History\n")
      end
    end

    context "when headers don't exist" do
      let(:lines) { [] }

      it "answers an empty array" do
        expect(subject.headers).to be_empty
      end
    end
  end

  describe "#build" do
    let :toc do
      "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
      "\n" \
      "# Table of Contents\n" \
      "\n" \
      "- [Overview](#overview)\n" \
      "- [Features](#features)\n" \
      "- [History](#history)\n" \
      "\n" \
      "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
      "\n"
    end

    context "when plain headers exist" do
      it "builds the table of contents" do
        expect(subject.build).to eq(toc)
      end
    end

    context "when linked headers exist" do
      let :lines do
        [
          "# [Overview](https://overview.example.com)\n",
          "# [Features](https://features.example.com)\n",
          "# [History](https://history.example.com)\n"
        ]
      end

      it "builds the table of contents" do
        expect(subject.build).to eq(toc)
      end
    end

    context "when duplicate anchors exist" do
      let :lines do
        [
          "# General\n",
          "# General\n",
          "# General\n"
        ]
      end
      let :toc do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# Table of Contents\n" \
        "\n" \
        "- [General](#general)\n" \
        "- [General](#general-1)\n" \
        "- [General](#general-2)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
        "\n"
      end

      it "builds the table of contents" do
        expect(subject.build).to eq(toc)
      end
    end

    context "when headers don't exist" do
      let(:lines) { [] }

      it "answers empty string" do
        expect(subject.build).to eq("")
      end
    end
  end
end
