# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Label do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "sets default label" do
      action.call
      expect(input.label).to eq("## Table of Contents")
    end

    it "sets custom label" do
      action.call "# A Test"
      expect(input.label).to eq("# A Test")
    end
  end
end
