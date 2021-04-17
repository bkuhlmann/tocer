# frozen_string_literal: true

require "refinements/pathnames"

module Tocer
  # Generates/updates Table of Contents for files in root path.
  class Runner
    using Refinements::Pathnames

    def initialize configuration: CLI::Configuration::Loader.call, writer: Writer.new
      @configuration = configuration
      @writer = writer
    end

    def call root_dir: ".", label: configuration.label, includes: configuration.includes
      Pathname(root_dir).files(%({#{includes.join ","}}))
                        .each do |path|
                          yield path if block_given?
                          writer.call path, label: label
                        end
    end

    private

    attr_reader :configuration, :writer
  end
end
