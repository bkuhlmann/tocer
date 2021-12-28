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

  describe "#unbuildable?" do
    it "answers true with placeholder and no headers" do
      lines = [
        "<!-- Tocer[start]: Auto-generated, don't remove. -->",
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->"
      ]

      expect(builder.unbuildable?(lines)).to eq(true)
    end

    it "answers false with placeholder and headers" do
      lines = [
        "<!-- Tocer[start]: Auto-generated, don't remove. -->",
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->",
        "# One"
      ]

      expect(builder.unbuildable?(lines)).to eq(false)
    end
  end

  describe "#call" do
    let :toc do
      <<~BODY
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Table of Contents

        - [Overview](#overview)
        - [Features](#features)
        - [History](#history)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->
      BODY
    end

    it "builds table of contents when headers exist" do
      expect(builder.call(lines)).to eq(toc)
    end

    it "builds identical table of contents when called multiple times" do
      builder.call lines
      expect(builder.call(lines)).to eq(toc)
    end

    context "with custom label" do
      let(:lines) { ["# Section 1\n", "# Section 2\n"] }

      it "builds customized table of contents" do
        expect(builder.call(lines, label: "# Overview")).to eq(<<~TOC)
          <!-- Tocer[start]: Auto-generated, don't remove. -->

          # Overview

          - [Section 1](#section-1)
          - [Section 2](#section-2)

          <!-- Tocer[finish]: Auto-generated, don't remove. -->
        TOC
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

      it "builds linked table of contents" do
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

      it "builds sequential table of contents" do
        expect(builder.call(lines)).to eq(<<~TOC)
          <!-- Tocer[start]: Auto-generated, don't remove. -->

          ## Table of Contents

          - [General](#general)
          - [General](#general-1)
          - [General](#general-2)

          <!-- Tocer[finish]: Auto-generated, don't remove. -->
        TOC
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
