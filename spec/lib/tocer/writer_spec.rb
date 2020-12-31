# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Writer do
  subject(:writer) { described_class.new test_path }

  include_context "with temporary directory"

  describe ".add" do
    let(:old_lines) { %w[a b c] }
    let(:new_lines) { "1 2 3" }

    it "prepend lines" do
      lines = described_class.add start_index: 0, old_lines: old_lines, new_lines: new_lines
      expect(lines).to contain_exactly("1 2 3", "a", "b", "c")
    end

    it "embeds lines" do
      lines = described_class.add start_index: 1, old_lines: old_lines, new_lines: new_lines
      expect(lines).to contain_exactly("a", "b", "1 2 3\n", "c")
    end

    it "appends lines" do
      lines = described_class.add start_index: 2, old_lines: old_lines, new_lines: new_lines
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
    let(:test_path) { File.join temp_dir, "test.md" }

    let :contents do
      "# Introduction\n" \
      "\n" \
      "Once upon a time...\n" \
      "\n" \
      "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
      "\n" \
      "## Table of Contents\n" \
      "\n"\
      "- [One](#one)\n" \
      "- [Two](#two)\n" \
      "- [Three](#three)\n" \
      "\n" \
      "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
      "\n" \
      "# One\n" \
      "# Two\n" \
      "# Three\n" \
      "\n" \
      "The end.\n"
    end

    before { FileUtils.cp fixture_path, test_path }

    context "when using a custom label" do
      subject(:writer) { described_class.new test_path, label: "# Index" }

      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "missing.md" }

      let :contents do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# Index\n" \
        "\n" \
        "- [One](#one)\n" \
        "- [Two](#two)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# One\n" \
        "# Two\n"
      end

      it "uses custom label for table of contents" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents exists and is empty" do
      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "empty.md" }

      it "replaces existing table of contents with new table of contents" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents is prepended in the document" do
      let :fixture_path do
        File.join Dir.pwd, "spec", "support", "fixtures", "existing-prepended.md"
      end

      let :contents do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "## Table of Contents\n" \
        "\n" \
        "- [One](#one)\n" \
        "- [Two](#two)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# One\n" \
        "# Two\n"
      end

      it "replaces existing table of contents with new table of contents" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents is embedded in the document" do
      let :fixture_path do
        File.join Dir.pwd, "spec", "support", "fixtures", "existing-embedded.md"
      end

      it "replaces existing table of contents with new table of contents" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents uses comments without auto-generated messages" do
      let :fixture_path do
        File.join Dir.pwd, "spec", "support", "fixtures", "without_comment_messages.md"
      end

      it "replaces existing table of contents with new table of contents" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents doesn't exist" do
      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "missing.md" }

      let :contents do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "## Table of Contents\n" \
        "\n" \
        "- [One](#one)\n" \
        "- [Two](#two)\n" \
        "\n" \
        "<!-- Tocer[finish]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# One\n" \
        "# Two\n"
      end

      it "prepends table of contents in file" do
        writer.call
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end
  end
end
