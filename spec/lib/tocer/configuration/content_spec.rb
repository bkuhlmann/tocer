# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Content do
  subject(:content) { described_class.new }

  describe "#initialize" do
    it "answers default attributes" do
      expect(content).to have_attributes(label: nil, includes: nil)
    end
  end
end
