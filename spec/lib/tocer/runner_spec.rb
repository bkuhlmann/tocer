# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Runner do
  subject(:runner) { described_class.new }

  using Refinements::Pathnames

  include_context "with temporary directory"

  describe "#call" do
    let(:shell) { class_spy Kernel }

    it "uses custom label" do
      path = temp_dir.join("README.md").touch.write <<~CONTENT
        <!-- Tocer[start] -->
        <!-- Tocer[finish] -->

        ## One
      CONTENT

      runner.call root_dir: temp_dir, label: "# Test"

      expect(path.read).to eq(<<~CONTENT)
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        # Test

          - [One](#one)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        ## One
      CONTENT
    end

    it "processes files with matching extensions" do
      test_path = temp_dir.join("test.md").touch
      runner.call(root_dir: temp_dir, includes: ["*.md"]) { |path| shell.print path }

      expect(shell).to have_received(:print).with(test_path)
    end

    it "processes with files with recursive includes" do
      test_path = temp_dir.join("nested").make_path.join("nested.md").touch
      runner.call(root_dir: temp_dir, includes: ["**/*.md"]) { |path| shell.print path }

      expect(shell).to have_received(:print).with(test_path)
    end

    it "doesn't process files when there are no files" do
      runner.call(root_dir: temp_dir) { |path| shell.print path }
      expect(shell).not_to have_received(:print)
    end

    it "doesn't process files for invalid path" do
      runner.call root_dir: "bogus"
      expect(shell).not_to have_received(:print)
    end

    it "doesn't process files with invalid includes" do
      temp_dir.join("test.md").touch
      runner.call(root_dir: temp_dir, includes: ["bogus", "~#}*^"]) { |path| shell.print path }

      expect(shell).not_to have_received(:print)
    end

    it "doesn't process files with missing wildcards" do
      temp_dir.join("test.md").touch
      runner.call(root_dir: temp_dir, includes: [".md"]) { |path| shell.print path }

      expect(shell).not_to have_received(:print)
    end
  end
end
