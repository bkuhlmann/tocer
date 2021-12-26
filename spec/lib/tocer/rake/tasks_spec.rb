# frozen_string_literal: true

require "spec_helper"
require "tocer/rake/tasks"

RSpec.describe Tocer::Rake::Tasks do
  subject(:tasks) { described_class.new runner: }

  let(:runner) { instance_spy Tocer::Runner }

  before { Rake::Task.clear }

  describe ".setup" do
    it "sets up Rake tasks" do
      described_class.setup
      expect(Rake::Task.tasks.map(&:name)).to contain_exactly("toc")
    end
  end

  describe "#install" do
    before { tasks.install }

    it "calls runner with default arguments" do
      Rake::Task["toc"].invoke

      expect(runner).to have_received(:call).with(
        label: "## Table of Contents",
        includes: ["README.md"]
      )
    end

    it "calls runner with custom arguments" do
      Rake::Task["toc"].invoke "## TOC", %w[one.md two.md]
      expect(runner).to have_received(:call).with(label: "## TOC", includes: %w[one.md two.md])
    end
  end
end
