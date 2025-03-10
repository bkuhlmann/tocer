# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Writer do
  using Refinements::Pathname

  subject(:writer) { described_class.new }

  include_context "with application dependencies"
  include_context "with temporary directory"

  describe ".add" do
    let(:old_lines) { %w[a b c] }
    let(:new_lines) { "1 2 3" }

    it "prepend lines" do
      lines = described_class.add(start_index: 0, old_lines:, new_lines:)
      expect(lines).to contain_exactly("1 2 3", "a", "b", "c")
    end

    it "embeds lines" do
      lines = described_class.add(start_index: 1, old_lines:, new_lines:)
      expect(lines).to contain_exactly("a", "b", "1 2 3\n", "c")
    end

    it "appends lines" do
      lines = described_class.add(start_index: 2, old_lines:, new_lines:)
      expect(lines).to contain_exactly("a", "b", "c", "1 2 3\n")
    end
  end

  describe ".remove" do
    let(:lines) { %w[a b c d e] }

    it "removes start of lines" do
      expect(described_class.remove(0, 2, lines)).to contain_exactly("d", "e")
    end

    it "removes embedded lines" do
      expect(described_class.remove(2, 3, lines)).to contain_exactly("a", "e")
    end

    it "removes end of lines" do
      expect(described_class.remove(4, 4, lines)).to contain_exactly("a", "b", "c")
    end
  end

  describe "#call" do
    let(:test_path) { temp_dir.join "test.md" }

    let :contents do
      <<~CONTENTS
        # Introduction

        Once upon a time...

        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Table of Contents

        - [One](#one)
        - [Two](#two)
        - [Three](#three)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        # One
        # Two
        # Three

        The end.
      CONTENTS
    end

    before { fixture_path.copy test_path }

    context "when using a custom label" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/missing.md" }

      it "uses custom label for table of contents" do
        settings.label = "# Index"
        writer.call test_path

        expect(test_path.read).to eq(<<~BODY)
          <!-- Tocer[start]: Auto-generated, don't remove. -->

          # Index

          - [One](#one)
          - [Two](#two)

          <!-- Tocer[finish]: Auto-generated, don't remove. -->

          # One
          # Two
        BODY
      end
    end

    context "when table of contents exists and is empty" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/empty.md" }

      it "replaces existing table of contents with new table of contents" do
        writer.call test_path
        expect(test_path.read).to eq(contents)
      end
    end

    context "when table of contents is prepended in the document" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/existing-prepended.md" }

      it "replaces existing table of contents with new table of contents" do
        writer.call test_path

        expect(test_path.read).to eq(<<~BODY)
          <!-- Tocer[start]: Auto-generated, don't remove. -->

          ## Table of Contents

          - [One](#one)
          - [Two](#two)

          <!-- Tocer[finish]: Auto-generated, don't remove. -->

          # One
          # Two
        BODY
      end
    end

    context "when table of contents is embedded in the document" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/existing-embedded.md" }

      it "replaces existing table of contents with new table of contents" do
        writer.call test_path
        expect(test_path.read).to eq(contents)
      end
    end

    context "when table of contents uses comments without auto-generated messages" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/without_comment_messages.md" }

      it "replaces existing table of contents with new table of contents" do
        writer.call test_path
        expect(test_path.read).to eq(contents)
      end
    end

    context "when table of contents is a placeholder" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/placeholder.md" }

      it "answers original document" do
        writer.call test_path

        expect(test_path.read).to eq(<<~COMMENTS)
          Once upon a time...

          <!-- Tocer[start]: Auto-generated, don't remove. -->
          <!-- Tocer[finish]: Auto-generated, don't remove. -->

          The end.
        COMMENTS
      end
    end

    context "when table of contents doesn't exist" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/missing.md" }

      it "prepends table of contents in file" do
        writer.call test_path

        expect(test_path.read).to eq(<<~BODY)
          <!-- Tocer[start]: Auto-generated, don't remove. -->

          ## Table of Contents

          - [One](#one)
          - [Two](#two)

          <!-- Tocer[finish]: Auto-generated, don't remove. -->

          # One
          # Two
        BODY
      end
    end

    context "when file has no headers" do
      let(:fixture_path) { SPEC_ROOT.join "support/fixtures/basic.md" }

      it "doesn't modify contents" do
        writer.call test_path
        expect(test_path.read).to eq("This is some *basic* Markdown.\n")
      end
    end
  end
end
