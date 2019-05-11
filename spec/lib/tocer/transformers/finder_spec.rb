# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Transformers::Finder do
  subject(:transformer) { described_class.new markdown }

  describe ".call" do
    it "answers text transformer" do
      expect(described_class.call("# Test")).to be_a(Tocer::Transformers::Text)
    end

    it "answers link transformer" do
      expect(described_class.call("# [Test](#test)")).to be_a(Tocer::Transformers::Link)
    end
  end
end
