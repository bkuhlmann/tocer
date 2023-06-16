# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Root do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "sets default root directory" do
      action.call
      expect(input.root_dir).to eq(temp_dir)
    end

    it "sets custom root directory" do
      action.call "a/path"
      expect(input.root_dir).to eq(Pathname("a/path"))
    end
  end
end
