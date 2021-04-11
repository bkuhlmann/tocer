# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Processors::Build do
  using Refinements::Pathnames

  subject(:processor) { described_class.new }

  include_context "with temporary directory"

  describe "#call" do
    it "calls runner with default arguments" do
      temp_dir.change_dir do
        expectation = proc { described_class.new.call }
        expect(&expectation).to output("").to_stdout
      end
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      expectation = proc { described_class.new.call temp_dir, label: "# Test", includes: ["*.md"] }

      expect(&expectation).to output("  #{path}\n").to_stdout
    end
  end
end
