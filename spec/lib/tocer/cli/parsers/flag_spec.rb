# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Parsers::Flag do
  subject(:parser) { described_class.new }

  it_behaves_like "a parser"

  describe "#call" do
    it "answers default label" do
      expect(parser.call(%w[--label])).to have_attributes(label: "## Table of Contents")
    end

    it "answers custom label" do
      expect(parser.call(["--label", "# Overview"])).to have_attributes(label: "# Overview")
    end

    it "answers default includes" do
      expect(parser.call(%w[--includes])).to have_attributes(includes: %w[README.md])
    end

    it "answers custom includes" do
      expect(parser.call(["--includes", "README.md,LICENSE.md"])).to have_attributes(
        includes: %w[README.md LICENSE.md]
      )
    end
  end
end
