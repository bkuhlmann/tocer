# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Configuration::Loader, :runcom do
  subject(:configuration) { described_class.new client: runcom_configuration }

  let :content do
    Tocer::CLI::Configuration::Content[
      label: "## Table of Contents",
      includes: %w[README.md]
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
