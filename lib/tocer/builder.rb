# frozen_string_literal: true

module Tocer
  # Builds a table of contents for a Markdown document.
  # :reek:TooManyInstanceVariables
  class Builder
    CODE_BLOCK_PUNCTUATION = "```"

    def self.transformer header
      if header.match?(/\[.+\]\(.+\)/)
        Transformers::Link.new header
      else
        Transformers::Text.new header
      end
    end

    def initialize lines, label: "# Table of Contents", comment_block: Elements::CommentBlock
      @lines = lines
      @label = label
      @comment_block = comment_block.new
      @url_count = Hash.new { |hash, key| hash[key] = 0 }
      @code_block = false
    end

    def headers
      lines.select do |line|
        toggle_code_block line
        line.start_with?(Parsers::Header::PUNCTUATION) && !code_block
      end
    end

    def build
      return "" if headers.empty?

      [
        "#{comment_block.start}\n\n",
        "#{label}\n\n",
        headers_as_links.join("\n"),
        "\n\n#{comment_block.finish}\n\n"
      ].join
    end

    private

    attr_reader :lines, :label, :comment_block, :url_count
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

    def headers_as_links
      headers.map { |header| transform header }
    end
  end
end
