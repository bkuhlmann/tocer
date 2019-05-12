# frozen_string_literal: true

require "forwardable"

module Tocer
  # Builds a table of contents for a Markdown document.
  class Builder
    extend Forwardable

    CODE_BLOCK_PUNCTUATION = "```"

    def_delegators :comment_block, :start_index, :finish_index, :prependable?

    def initialize label: "## Table of Contents", comment_block: Elements::CommentBlock.new
      @label = label
      @comment_block = comment_block
      @url_count = Hash.new 0
      @code_block = false
    end

    def call lines
      return "" if headers(lines).empty?

      [
        "#{comment_block.start_tag}\n\n",
        "#{label}\n\n",
        links(lines).join("\n"),
        "\n\n#{comment_block.finish_tag}\n"
      ].join
    end

    private

    attr_reader :label, :comment_block, :url_count
    attr_accessor :code_block

    def links lines
      headers(lines).map { |markdown| transform markdown }
    end

    def headers lines
      lines.select do |line|
        toggle_code_block line
        line.start_with?(Parsers::Header::PUNCTUATION) && !code_block
      end
    end

    def toggle_code_block line
      return unless line.start_with? CODE_BLOCK_PUNCTUATION

      self.code_block = !code_block
    end

    def transform markdown
      Transformers::Finder.call(markdown).then do |transformer|
        url = transformer.url
        link = transformer.call url_suffix: url_suffix(url)
        url_count[url] += 1
        link
      end
    end

    def url_suffix url
      url_count[url].then { |count| count.zero? ? "" : count }
    end
  end
end
