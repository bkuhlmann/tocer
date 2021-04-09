# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Parsers::Build do
  subject(:parser) { described_class.new options: options }

  let(:options) { {} }

  it_behaves_like "a parser"

  describe "#call" do
    it "answers default label (short)" do
      parser.call %w[-l]
      expect(options).to eq(label: "## Table of Contents")
    end

    it "answers custom label (short)" do
      parser.call ["-l", "# Overview"]
      expect(options).to eq(label: "# Overview")
    end

    it "answers default label (long)" do
      parser.call %w[--label]
      expect(options).to eq(label: "## Table of Contents")
    end

    it "answers custom label (long)" do
      parser.call ["--label", "# Overview"]
      expect(options).to eq(label: "# Overview")
    end

    it "answers default includes (short)" do
      parser.call %w[-i]
      expect(options).to eq(includes: %w[README.md])
    end

    it "answers custom includes (short)" do
      parser.call ["-i", "README.md,LICENSE.md"]
      expect(options).to eq(includes: %w[README.md LICENSE.md])
    end

    it "answers default includes (long)" do
      parser.call %w[--includes]
      expect(options).to eq(includes: %w[README.md])
    end

    it "answers custom includes (long)" do
      parser.call ["--includes", "README.md,LICENSE.md"]
      expect(options).to eq(includes: %w[README.md LICENSE.md])
    end
  end
end
