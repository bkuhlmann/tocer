# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Parsers::Assembler do
  subject(:parser) { described_class.new configuration: {} }

  describe "#call" do
    it "answers hash with valid option" do
      expect(parser.call(%w[--help])).to eq(help: true)
    end

    it "answers empty hash by default" do
      expect(parser.call).to eq({})
    end

    it "fails with invalid option" do
      expectation = proc { parser.call %w[--bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidOption, /--bogus/)
    end
  end

  describe "#to_h" do
    it "answers hash with valid option" do
      parser.call %w[--help]
      expect(parser.to_h).to eq(help: true)
    end

    it "answers empty hash without options" do
      parser.call
      expect(parser.to_h).to eq({})
    end
  end

  describe "#to_s" do
    it "answers usage" do
      parser.call
      expect(parser.to_s).to match(/.+USAGE.+BUILD\sOPTIONS.+/m)
    end
  end
end
