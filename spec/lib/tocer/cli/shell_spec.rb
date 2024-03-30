# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Shell do
  using Refinements::Pathname
  using Refinements::Struct

  subject(:shell) { described_class.new }

  include_context "with application dependencies"

  let(:fixture_path) { SPEC_ROOT.join "support/fixtures/missing.md" }

  before { Sod::Container.stub! kernel:, logger: }

  after { Sod::Container.restore }

  describe "#call" do
    it "prints configuration usage" do
      shell.call %w[config]
      expect(kernel).to have_received(:puts).with(/Manage configuration.+/m)
    end

    it "upserts with defaults" do
      path = temp_dir.join "README.md"
      fixture_path.copy path
      shell.call ["upsert", "--root", temp_dir.to_s]

      expect(path.read).to eq(<<~CONTENT)
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Table of Contents

        - [One](#one)
        - [Two](#two)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        # One
        # Two
      CONTENT
    end

    it "upserts with custom configuration" do
      path = temp_dir.join "test.md"
      fixture_path.copy path
      shell.call ["upsert", "--root", temp_dir.to_s, "--label", "## Test", "--patterns", "*.md"]

      expect(path.read).to eq(<<~CONTENT)
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Test

        - [One](#one)
        - [Two](#two)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        # One
        # Two
      CONTENT
    end

    it "upserts with nested path" do
      path = temp_dir.join("nested/README.md").make_ancestors
      fixture_path.copy path
      shell.call ["upsert", "--root", temp_dir.to_s, "--patterns", "**/*.md"]

      expect(path.read).to eq(<<~CONTENT)
        <!-- Tocer[start]: Auto-generated, don't remove. -->

        ## Table of Contents

        - [One](#one)
        - [Two](#two)

        <!-- Tocer[finish]: Auto-generated, don't remove. -->

        # One
        # Two
      CONTENT
    end

    it "prints version" do
      shell.call %w[--version]
      expect(kernel).to have_received(:puts).with(/Tocer\s\d+\.\d+\.\d+/)
    end

    it "prints help" do
      shell.call %w[--help]
      expect(kernel).to have_received(:puts).with(/Tocer.+USAGE.+/m)
    end
  end
end
