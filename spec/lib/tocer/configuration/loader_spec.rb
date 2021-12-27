# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::Configuration::Loader do
  subject(:configuration) { described_class.new client: runcom_configuration }

  include_context "with Runcom"

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

  describe "#call" do
    it "answers default configuration" do
      expect(configuration.call).to eq(content)
    end
  end
end
