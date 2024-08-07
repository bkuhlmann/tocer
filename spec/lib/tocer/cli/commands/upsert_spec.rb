# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Commands::Upsert do
  using Refinements::Pathname
  using Refinements::StringIO

  subject(:command) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "calls runner with default arguments" do
      expectation = proc { command.call }
      expect(&expectation).to output("").to_stdout
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      settings.patterns = %w[*.md]
      command.call

      expect(io.reread).to eq("  #{path}\n")
    end
  end
end
