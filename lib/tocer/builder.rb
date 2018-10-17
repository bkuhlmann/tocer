# frozen_string_literal: true

require "forwardable"

module Tocer
  # Builds a table of contents for a Markdown document.
  class Builder
    extend Forwardable

    CODE_BLOCK_PUNCTUATION = "```"

    def_delegators :comment_block, :start_index, :finish_index, :prependable?

    def self.transformer header
      if header.match?(/\[.+\]\(.+\)/)
        Transformers::Link.new header
      else
        Transformers::Text.new header
      end
    end

    def initialize label: "## Table of Contents", comment_block: Elements::CommentBlock.new
      @label = label
      @comment_block = comment_block
      @url_count = Hash.new { |hash, key| hash[key] = 0 }
      @code_block = false
    end

    def build lines
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

    def toggle_code_block line
      return unless line.start_with? CODE_BLOCK_PUNCTUATION

      self.code_block = !code_block
    end

    def url_suffix url
      count = url_count[url]
      count.zero? ? "" : count
    end

    def transform header
      transformer = self.class.transformer header
      url = transformer.url
      link = transformer.transform url_suffix: url_suffix(url)
      url_count[url] += 1
      link
    end

    def headers lines
      lines.select do |line|
        toggle_code_block line
        line.start_with?(Parsers::Header::PUNCTUATION) && !code_block
      end
    end

    def links lines
      headers(lines).map { |header| transform header }
    end
  end
end
