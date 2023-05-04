# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Model do
  subject(:content) { described_class.new }

  describe "#initialize" do
    it "answers default attributes" do
      expect(content).to have_attributes(label: nil, root_dir: nil, patterns: [])
    end
  end
end
