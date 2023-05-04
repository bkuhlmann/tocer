# frozen_string_literal: true

require "refinements/pathnames"

module Tocer
  # Generates/updates Table of Contents for files in root path.
  class Runner
    include Import[:kernel]

    using Refinements::Pathnames

    def initialize(writer: Writer.new, **)
      super(**)
      @writer = writer
    end

    # :reek:FeatureEnvy
    def call configuration
      configuration.root_dir
                   .files(%({#{configuration.patterns.join ","}}))
                   .each do |path|
                     kernel.puts "  #{path}"
                     writer.call path, label: configuration.label
                   end
    end

    private

    attr_reader :writer
  end
end
