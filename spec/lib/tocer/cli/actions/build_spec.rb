# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Build do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:action) { described_class.new }

  include_context "with application configuration"

  describe "#call" do
    it "calls runner with default arguments" do
      expectation = proc { action.call configuration }
      expect(&expectation).to output("").to_stdout
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      expectation = proc { action.call configuration.merge(build_includes: %w[*.md]) }

      expect(&expectation).to output("  #{path}\n").to_stdout
    end
  end
end