# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Builder do
  subject(:builder) { described_class.new }

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

  describe "#call" do
    let :toc do
      "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
      "\n" \
      "## Table of Contents\n" \
      "\n" \
      "- [Overview](#overview)\n" \
      "- [Features](#features)\n" \
      "- [History](#history)\n" \
      "\n" \
      "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n"
    end

    context "with custom label" do
      subject(:builder) { described_class.new label: "# Overview" }

      let(:lines) { ["# Section 1\n", "# Section 2\n"] }

      let :toc do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# Overview\n" \
        "\n" \
        "- [Section 1](#section-1)\n" \
        "- [Section 2](#section-2)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n"
      end

      it "builds table of contents" do
        expect(builder.call(lines)).to eq(toc)
      end
    end

    context "with plain headers" do
      it "builds table of contents" do
        expect(builder.call(lines)).to eq(toc)
      end
    end

    context "with embedded header links" do
      let :lines do
        [
          "# [Overview](https://overview.example.com)\n",
          "# [Features](https://features.example.com)\n",
          "# [History](https://history.example.com)\n"
        ]
      end

      it "builds table of contents" do
        expect(builder.call(lines)).to eq(toc)
      end
    end

    context "with duplicate anchors" do
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
        "## Table of Contents\n" \
        "\n" \
        "- [General](#general)\n" \
        "- [General](#general-1)\n" \
        "- [General](#general-2)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n"
      end

      it "builds table of contents" do
        expect(builder.call(lines)).to eq(toc)
      end
    end

    context "with commented code block lines" do
      let :lines do
        [
          "```",
          "# This is a comment.",
          "class Example",
          "end",
          "```"
        ]
      end

      it "answers an empty array" do
        expect(builder.call(lines)).to eq("")
      end
    end

    context "when headers don't exist" do
      let(:lines) { [] }

      it "answers empty string" do
        expect(builder.call(lines)).to eq("")
      end
    end
  end
end
