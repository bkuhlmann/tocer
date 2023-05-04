# frozen_string_literal: true

require "spec_helper"
require "tocer/rake/register"

RSpec.describe Tocer::Rake::Register do
  subject(:tasks) { described_class.new configuration, runner: }

  include_context "with application dependencies"

  let(:runner) { instance_spy Tocer::Runner }

  before { Rake::Task.clear }

  describe ".call" do
    it "sets up Rake tasks" do
      described_class.call
      expect(Rake::Task.tasks.map(&:name)).to contain_exactly("toc")
    end
  end

  describe "#call" do
    before { tasks.call }

    it "calls runner with default arguments" do
      Rake::Task["toc"].invoke

      expect(runner).to have_received(:call).with(configuration)
    end

    it "calls runner with custom arguments" do
      Rake::Task["toc"].invoke "## TOC", %w[one.md two.md]

      expect(runner).to have_received(:call).with(
        Tocer::Configuration::Model[
          label: "## TOC",
          root_dir: temp_dir,
          patterns: %w[one.md two.md]
        ]
      )
    end
  end
end
