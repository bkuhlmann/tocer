# frozen_string_literal: true

require "spec_helper"

RSpec.describe Tocer::CLI::Actions::Build do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:action) { described_class.new }

  include_context "with temporary directory"

  describe "#call" do
    let :configuration do
      Tocer::Configuration::Content[
        build_includes: %w[README.md],
        build_label: "## Table of Contents",
        build_path: "."
      ]
    end

    it "calls runner with default arguments" do
      temp_dir.change_dir do
        expectation = proc { action.call configuration }
        expect(&expectation).to output("").to_stdout
      end
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch

      expectation = proc do
        action.call configuration.merge(build_path: temp_dir, build_includes: %w[*.md])
      end

      expect(&expectation).to output("  #{path}\n").to_stdout
    end
  end
end
