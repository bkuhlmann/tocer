# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Pattern do
  subject(:action) { described_class.new inputs: }

  let(:inputs) { configuration.dup }

  include_context "with application dependencies"

  describe "#call" do
    it "sets default patterns" do
      action.call
      expect(inputs.patterns).to eq(["README.md"])
    end

    it "sets custom pattern" do
      action.call [".md"]
      expect(inputs.patterns).to eq([".md"])
    end

    it "sets custom patterns" do
      action.call [".md", "**/*.md"]
      expect(inputs.patterns).to eq([".md", "**/*.md"])
    end
  end
end
