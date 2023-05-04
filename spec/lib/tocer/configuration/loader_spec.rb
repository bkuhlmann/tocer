# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Loader do
  subject(:configuration) { described_class.with_defaults }

  let :model do
    Tocer::Configuration::Model[
      includes: %w[README.md],
      label: "## Table of Contents",
      root_dir: "."
    ]
  end

  describe ".call" do
    it "answers default configuration" do
      expect(described_class.call).to eq(model)
    end
  end

  describe ".with_defaults" do
    it "answers default configuration" do
      expect(described_class.with_defaults.call).to eq(model)
    end
  end

  describe "#call" do
    it "answers default configuration" do
      expect(configuration.call).to eq(model)
    end
  end
end
