# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Loader do
  subject(:configuration) { described_class.with_defaults }

  let :content do
    Tocer::Configuration::Content[
      build_includes: %w[README.md],
      build_label: "## Table of Contents",
      build_path: "."
    ]
  end

  describe ".call" do
    it "answers default configuration" do
      expect(described_class.call).to eq(content)
    end
  end

  describe ".with_defaults" do
    it "answers default configuration" do
      expect(described_class.with_defaults.call).to eq(content)
    end
  end

  describe "#call" do
    it "answers default configuration" do
      expect(configuration.call).to eq(content)
    end
  end
end
