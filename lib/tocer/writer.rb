# frozen_string_literal: true

module Tocer
  # Writes table of contents to a Markdown document.
  class Writer
    # rubocop:disable Metrics/ParameterLists
    def initialize file_path,
                   label: "# Table of Contents",
                   builder: Builder,
                   comment_block: Elements::CommentBlock

      @file_path = file_path
      @file_lines = File.open(file_path).to_a
      @label = label
      @builder = builder
      setup_indexes comment_block.new, @file_lines
    end

    def write
      body = start_index ? replace_toc : prepend_toc
      File.open(file_path, "w") { |file| file.write body }
    end

    private

    attr_reader :file_path,
                :file_lines,
                :label,
                :start_index,
                :finish_index,
                :builder,
                :comment_block

    def setup_indexes comment_block, lines
      @start_index = comment_block.start_index lines
      @finish_index = comment_block.finish_index lines
    end

    def content lines
      builder.new(lines, label: label).build
    end

    def remove_toc lines
      toc_range = ((start_index - 1)..finish_index)
      lines.reject.with_index { |_, index| toc_range.include? index }
    end

    def add_toc old_lines, new_lines
      old_lines.insert start_index, new_lines
    end

    def replace_toc
      old_lines = remove_toc file_lines
      new_lines = content file_lines[finish_index, file_lines.length]

      add_toc(old_lines, new_lines).join
    end

    def prepend_toc
      content(file_lines).dup << file_lines.join
    end
  end
end
