# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Commands::Upsert do
  using Refinements::Structs
  using Refinements::Pathnames

  subject(:command) { described_class.new inputs: }

  include_context "with application dependencies"

  let(:inputs) { configuration.dup.merge! root_dir: temp_dir }

  describe "#call" do
    it "calls runner with default arguments" do
      expectation = proc { command.call }
      expect(&expectation).to output("").to_stdout
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      inputs.patterns = %w[*.md]
      command.call

      expect(kernel).to have_received(:puts).with("  #{path}")
    end
  end
end
