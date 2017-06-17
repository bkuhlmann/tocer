# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Writer do
  subject { described_class.new test_path }

  describe "#write", :temp_dir do
    let(:test_path) { File.join temp_dir, "test.md" }
    let :contents do
      "# Introduction\n" \
      "\n" \
      "Once upon a time...\n" \
      "\n" \
      "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
      "\n" \
      "# Table of Contents\n" \
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
      subject { described_class.new test_path, label: "# Index" }

      it "uses custom label for table of contents" do
        subject.write
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents exists and is empty" do
      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "empty.md" }

      it "replaces existing table of contents with new table of contents" do
        subject.write
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents exists" do
      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "existing.md" }

      it "replaces existing table of contents with new table of contents" do
        subject.write
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents uses comments without auto-generated messages" do
      let :fixture_path do
        File.join Dir.pwd, "spec", "support", "fixtures", "without_comment_messages.md"
      end

      it "replaces existing table of contents with new table of contents" do
        subject.write
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end

    context "when table of contents doesn't exist" do
      let(:fixture_path) { File.join Dir.pwd, "spec", "support", "fixtures", "missing.md" }
      let :contents do
        "<!-- Tocer[start]: Auto-generated, don't remove. -->\n" \
        "\n" \
        "# Table of Contents\n" \
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
        subject.write
        File.open(test_path, "r") { |file| expect(file.to_a.join).to eq(contents) }
      end
    end
  end
end
