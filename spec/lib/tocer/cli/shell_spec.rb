# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Shell do
  using Refinements::Pathnames
  using Refinements::StringIOs
  using AutoInjector::Stub

  subject(:shell) { described_class.new }

  include_context "with application container"

  let(:config) { instance_spy Tocer::CLI::Actions::Config }
  let(:fixture_path) { Bundler.root.join "spec/support/fixtures/missing.md" }

  before { Tocer::CLI::Actions::Import.stub configuration:, kernel:, logger: }

  after { Tocer::CLI::Actions::Import.unstub :configuration, :kernel, :logger }

  describe "#call" do
    it "edits configuration" do
      shell.call %w[--config edit]
      expect(kernel).to have_received(:system).with("$EDITOR ")
    end

    it "views configuration" do
      shell.call %w[--config view]
      expect(kernel).to have_received(:system).with("cat ")
    end

    it "inserts with defaults" do
      path = temp_dir.join "README.md"
      fixture_path.copy path
      shell.call ["--insert", temp_dir.to_s]

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

    it "inserts with custom configuration" do
      path = temp_dir.join "test.md"
      fixture_path.copy path
      shell.call ["--insert", temp_dir.to_s, "--label", "## Test", "--includes", "*.md"]

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

    it "inserts with nested path" do
      path = temp_dir.join("nested/README.md").make_ancestors
      fixture_path.copy path
      shell.call ["--insert", temp_dir.to_s, "--includes", "**/*.md"]

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
      expect(logger.reread).to match(/Tocer\s\d+\.\d+\.\d+/)
    end

    it "prints help (usage)" do
      shell.call %w[--help]
      expect(logger.reread).to match(/Tocer.+USAGE.+OPTIONS/m)
    end

    it "prints usage when no options are given" do
      shell.call
      expect(logger.reread).to match(/Tocer.+USAGE.+OPTIONS.+/m)
    end
  end
end
