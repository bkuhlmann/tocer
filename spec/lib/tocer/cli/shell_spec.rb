# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Shell do
  using Refinements::Pathnames

  subject(:shell) { described_class.new actions: described_class::ACTIONS.merge(config:) }

  include_context "with temporary directory"

  let(:config) { instance_spy Tocer::CLI::Actions::Config }
  let(:fixture_path) { Bundler.root.join "spec/support/fixtures/missing.md" }

  describe "#call" do
    it "edits configuration" do
      shell.call %w[--config edit]
      expect(config).to have_received(:call).with(:edit)
    end

    it "views configuration" do
      shell.call %w[--config view]
      expect(config).to have_received(:call).with(:view)
    end

    it "builds with defaults" do
      path = temp_dir.join "README.md"
      fixture_path.copy path
      shell.call ["--build", temp_dir.to_s]

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

    it "builds with custom configuration" do
      path = temp_dir.join "test.md"
      fixture_path.copy path
      shell.call ["--build", temp_dir.to_s, "--label", "## Test", "--includes", "*.md"]

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

    it "builds nested path" do
      path = temp_dir.join("nested/README.md").make_ancestors
      fixture_path.copy path
      shell.call ["--build", temp_dir.to_s, "--includes", "**/*.md"]

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
      expectation = proc { shell.call %w[--version] }
      expect(&expectation).to output(/Tocer\s\d+\.\d+\.\d+/).to_stdout
    end

    it "prints help (usage)" do
      expectation = proc { shell.call %w[--help] }
      expect(&expectation).to output(/Tocer.+USAGE.+BUILD OPTIONS/m).to_stdout
    end

    it "prints usage when no options are given" do
      expectation = proc { shell.call }
      expect(&expectation).to output(/Tocer.+USAGE.+BUILD OPTIONS.+/m).to_stdout
    end

    it "prints error with invalid option" do
      expectation = proc { shell.call %w[--bogus] }
      expect(&expectation).to output(/invalid option.+bogus/).to_stdout
    end
  end
end
