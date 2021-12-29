# frozen_string_literal: true

require "refinements/pathnames"

module Tocer
  # Generates/updates Table of Contents for files in root path.
  class Runner
    using Refinements::Pathnames

    def initialize writer: Writer.new
      @writer = writer
    end

    def call configuration
      Pathname(configuration.root_dir).files(%({#{configuration.includes.join ","}}))
                                      .each do |path|
                                        yield path if block_given?
                                        writer.call path, label: configuration.label
                                      end
    end

    private

    attr_reader :writer
  end
end
