# frozen_string_literal: true

require "refinements/pathname"

module Tocer
  # Generates/updates Table of Contents for files in root path.
  class Runner
    include Dependencies[:settings, :io]

    using Refinements::Pathname

    def initialize(writer: Writer.new, **)
      super(**)
      @writer = writer
    end

    def call
      settings.root_dir
              .files(%({#{settings.patterns.join ","}}))
              .each do |path|
                io.puts "  #{path}"
                writer.call path
              end
    end

    private

    attr_reader :writer
  end
end
