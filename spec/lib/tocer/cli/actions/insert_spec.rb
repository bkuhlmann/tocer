# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Insert do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "calls runner with default arguments" do
      expectation = proc { action.call configuration }
      expect(&expectation).to output("").to_stdout
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      action.call configuration.merge(includes: %w[*.md])

      expect(kernel).to have_received(:puts).with("  #{path}")
    end
  end
end
