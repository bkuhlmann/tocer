# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Runner do
  subject(:runner) { described_class.new }

  using Refinements::Pathname
  using Refinements::StringIO

  include_context "with application dependencies"

  describe "#call" do
    it "uses custom label" do
      path = temp_dir.join("README.md").touch.write <<~CONTENT
        <!-- Tocer[start] -->
        <!-- Tocer[finish] -->

        ## One
      CONTENT

      runner.call

      expect(path.read).to eq(<<~CONTENT)
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Table of Contents

          - [One](#one)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        ## One
      CONTENT
    end

    it "processes files with matching extensions" do
      test_path = temp_dir.join("test.md").touch
      settings.patterns = %w[*.md]
      runner.call

      expect(io.reread).to eq("  #{test_path}\n")
    end

    it "processes with files with recursive patterns" do
      test_path = temp_dir.join("nested").mkpath.join("nested.md").touch
      settings.patterns = %w[**/*.md]
      runner.call

      expect(io.reread).to eq("  #{test_path}\n")
    end

    it "doesn't process files when there are no files" do
      runner.call { |path| io.print path }
      expect(io.reread).to eq("")
    end

    it "doesn't process files for invalid path" do
      settings.root_dir = Pathname "bogus"
      runner.call

      expect(io.reread).to eq("")
    end

    it "doesn't process files with invalid patterns" do
      temp_dir.join("test.md").touch
      settings.patterns = ["bogus", "~#}*^"]
      runner.call { |path| io.print path }

      expect(io.reread).to eq("")
    end

    it "doesn't process files with missing wildcards" do
      temp_dir.join("test.md").touch
      settings.patterns = %w[.md]
      runner.call { |path| io.print path }

      expect(io.reread).to eq("")
    end
  end
end
