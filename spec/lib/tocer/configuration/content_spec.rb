# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Content do
  subject(:content) { described_class.new }

  describe "#initialize" do
    it "answers default attributes" do
      expect(content).to have_attributes(
        action_build: nil,
        action_config: nil,
        action_help: nil,
        action_version: nil,
        build_includes: nil,
        build_label: nil,
        build_path: nil
      )
    end
  end
end
