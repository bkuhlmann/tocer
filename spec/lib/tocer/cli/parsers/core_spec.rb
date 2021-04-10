# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Parsers::Core do
  subject(:parser) { described_class.new options: options }

  let(:options) { {} }

  it_behaves_like "a parser"

  describe "#call" do
    it "answers config edit (short)" do
      parser.call %w[-c edit]
      expect(options).to eq(config: :edit)
    end

    it "answers config edit (long)" do
      parser.call %w[--config edit]
      expect(options).to eq(config: :edit)
    end

    it "answers config view (short)" do
      parser.call %w[-c view]
      expect(options).to eq(config: :view)
    end

    it "answers config view (long)" do
      parser.call %w[--config view]
      expect(options).to eq(config: :view)
    end

    it "fails with missing config action" do
      expectation = proc { parser.call %w[--config] }
      expect(&expectation).to raise_error(OptionParser::MissingArgument, /--config/)
    end

    it "fails with invalid config action" do
      expectation = proc { parser.call %w[--config bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidArgument, /bogus/)
    end

    it "answers build default path (short)" do
      parser.call %w[-b]
      expect(options).to eq(build: ".")
    end

    it "answers build custom path (short)" do
      parser.call %w[-b one/two/three]
      expect(options).to eq(build: "one/two/three")
    end

    it "answers build default path (long)" do
      parser.call %w[--build]
      expect(options).to eq(build: ".")
    end

    it "answers build custom path (long)" do
      parser.call %w[--build one/two/three]
      expect(options).to eq(build: "one/two/three")
    end

    it "answers version (short)" do
      parser.call %w[-v]
      expect(options[:version]).to match(/Tocer\s\d+\.\d+\.\d+/)
    end

    it "answers version (long)" do
      parser.call %w[--version]
      expect(options[:version]).to match(/Tocer\s\d+\.\d+\.\d+/)
    end

    it "enables help (short)" do
      parser.call %w[-h]
      expect(options).to eq(help: true)
    end

    it "enables help (long)" do
      parser.call %w[--help]
      expect(options).to eq(help: true)
    end
  end
end
