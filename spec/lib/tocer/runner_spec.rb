# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Runner do
  subject(:runner) { described_class.new }

  using Refinements::Pathname
  using Refinements::Struct

  include_context "with application dependencies"

  describe "#call" do
    it "uses custom label" do
      path = temp_dir.join("README.md").touch.write <<~CONTENT
        <!-- Tocer[start] -->
        <!-- Tocer[finish] -->

        ## One
      CONTENT

      runner.call configuration

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
      runner.call configuration.merge(patterns: %w[*.md])

      expect(kernel).to have_received(:puts).with("  #{test_path}")
    end

    it "processes with files with recursive patterns" do
      test_path = temp_dir.join("nested").make_path.join("nested.md").touch
      runner.call configuration.merge(patterns: %w[**/*.md])

      expect(kernel).to have_received(:puts).with("  #{test_path}")
    end

    it "doesn't process files when there are no files" do
      runner.call(configuration) { |path| kernel.print path }
      expect(kernel).not_to have_received(:print)
    end

    it "doesn't process files for invalid path" do
      runner.call configuration.merge(root_dir: Pathname("bogus"))
      expect(kernel).not_to have_received(:print)
    end

    it "doesn't process files with invalid patterns" do
      temp_dir.join("test.md").touch
      test_configuration = configuration.merge patterns: ["bogus", "~#}*^"]
      runner.call(test_configuration) { |path| kernel.print path }

      expect(kernel).not_to have_received(:print)
    end

    it "doesn't process files with missing wildcards" do
      temp_dir.join("test.md").touch
      runner.call(configuration.merge(patterns: %w[.md])) { |path| kernel.print path }

      expect(kernel).not_to have_received(:print)
    end
  end
end
