# frozen_string_literal: true

require "refinements/pathnames"

module Tocer
  # Writes table of contents to a Markdown document.
  # :reek:DataClump
  class Writer
    using Refinements::Pathnames

    def self.add start_index:, old_lines:, new_lines:
      computed_new_lines = start_index.zero? ? new_lines : new_lines + "\n"
      old_lines.insert start_index, *computed_new_lines
    end

    def self.remove start_index, finish_index, lines
      range = (start_index - 1)..finish_index
      lines.reject.with_index { |_, index| range.include? index }
    end

    def initialize builder: Builder.new
      @builder = builder
    end

    def call path, label: CLI::Configuration::Loader.call.label
      path.rewrite do |body|
        lines = body.each_line.to_a
        builder.prependable?(lines) ? prepend(lines, label) : replace(lines, label)
      end
    end

    private

    attr_reader :builder

    def replace lines, label
      start_index = builder.start_index lines
      finish_index = builder.finish_index lines
      klass = self.class

      klass.add(
        start_index: start_index,
        old_lines: klass.remove(start_index, finish_index, lines),
        new_lines: content(lines[finish_index, lines.length], label)
      ).join
    end

    def prepend(lines, label) = content(lines, label) + "\n" + lines.join

    def content(lines, label) = builder.call(lines, label: label)
  end
end
