# frozen_string_literal: true

require "spec_helper"
require "tocer/rake/tasks"

RSpec.describe Tocer::Rake::Tasks do
  subject(:tasks) { described_class.new runner: runner_class }

  let(:runner_class) { class_double Tocer::Runner }
  let(:runner_instance) { instance_spy Tocer::Runner }

  before { Rake::Task.clear }

  describe ".setup" do
    subject(:tasks) { instance_spy described_class }

    before { allow(described_class).to receive(:new).and_return(tasks) }

    it "sets up Rake tasks" do
      described_class.setup
      expect(tasks).to have_received(:install)
    end
  end

  describe "#install" do
    before do
      allow(runner_class).to receive(:new).with(configuration: configuration)
                                          .and_return(runner_instance)
      tasks.install
    end

    context "with no toc task arguments" do
      let(:configuration) { {label: "## Table of Contents", includes: ["README.md"]} }

      it "executes runner" do
        Rake::Task["toc"].invoke
        expect(runner_instance).to have_received(:run)
      end
    end

    context "with toc arguments" do
      let(:configuration) { {label: "## TOC", includes: %w[one.md two.md]} }

      it "executes runner" do
        Rake::Task["toc"].invoke "## TOC", %w[one.md two.md]
        expect(runner_instance).to have_received(:run)
      end
    end
  end
end
