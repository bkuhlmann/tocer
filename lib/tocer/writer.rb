# frozen_string_literal: true

module Tocer
  # Writes table of contents to a Markdown document.
  class Writer
    def self.add start_index:, old_lines:, new_lines:
      computed_new_lines = start_index.zero? ? new_lines : new_lines + "\n"
      old_lines.insert start_index, *computed_new_lines
    end

    def self.remove start_index, finish_index, lines
      range = (start_index - 1)..finish_index
      lines.reject.with_index { |_, index| range.include? index }
    end

    # rubocop:disable Style/CommentedKeyword
    def initialize file_path, label: "## Table of Contents", builder: Builder.new(label: label)
      @file_path = file_path
      @builder = builder
    end

    def write
      lines = File.readlines file_path
      body = builder.prependable?(lines) ? unshift(lines) : replace(lines)
      File.open(file_path, "w") { |file| file.write body }
    end

    private

    attr_reader :file_path, :builder

    def content lines
      builder.build lines
    end

    def replace lines
      start_index = builder.start_index lines
      finish_index = builder.finish_index lines
      klass = self.class

      klass.add(
        start_index: start_index,
        old_lines: klass.remove(start_index, finish_index, lines),
        new_lines: content(lines[finish_index, lines.length])
      ).join
    end

    def unshift lines
      content(lines) + "\n" + lines.join
    end
  end
end
