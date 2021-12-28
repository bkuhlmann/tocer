# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Parsers::Build do
  subject(:parser) { described_class.new }

  it_behaves_like "a parser"

  describe "#call" do
    it "answers default label (short)" do
      expect(parser.call(%w[-l])).to have_attributes(build_label: "## Table of Contents")
    end

    it "answers custom label (short)" do
      expect(parser.call(["-l", "# Overview"])).to have_attributes(build_label: "# Overview")
    end

    it "answers default label (long)" do
      expect(parser.call(%w[--label])).to have_attributes(build_label: "## Table of Contents")
    end

    it "answers custom label (long)" do
      expect(parser.call(["--label", "# Overview"])).to have_attributes(build_label: "# Overview")
    end

    it "answers default includes (short)" do
      expect(parser.call(%w[-i])).to have_attributes(build_includes: %w[README.md])
    end

    it "answers custom includes (short)" do
      expect(parser.call(["-i", "README.md,LICENSE.md"])).to have_attributes(
        build_includes: %w[README.md LICENSE.md]
      )
    end

    it "answers default includes (long)" do
      expect(parser.call(%w[--includes])).to have_attributes(build_includes: %w[README.md])
    end

    it "answers custom includes (long)" do
      expect(parser.call(["--includes", "README.md,LICENSE.md"])).to have_attributes(
        build_includes: %w[README.md LICENSE.md]
      )
    end
  end
end
