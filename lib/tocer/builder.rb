# frozen_string_literal: true

require "forwardable"

module Tocer
  # Builds table of contents for a Markdown document.
  class Builder
    extend Forwardable

    CODE_BLOCK_PUNCTUATION = "```"

    def_delegators :comment_block, :start_index, :finish_index, :prependable?

    def initialize comment_block: Elements::CommentBlock.new, transformer: Transformers::Finder.new
      @comment_block = comment_block
      @transformer = transformer
      @url_count = Hash.new 0
      @code_block = false
    end

    def call lines, label: Configuration::Loader.call.build_label
      return "" if headers(lines).empty?

      url_count.clear
      assemble(lines, label).join
    end

    private

    attr_reader :comment_block, :transformer, :url_count
    attr_accessor :code_block

    def assemble lines, label
      [
        "#{comment_block.start_tag}\n\n",
        "#{label}\n\n",
        links(lines).join("\n"),
        "\n\n#{comment_block.finish_tag}\n"
      ]
    end

    def links(lines) = headers(lines).map { |markdown| transform markdown }

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
      transformer.call(markdown).then do |instance|
        url = instance.url
        link = instance.call url_suffix: url_suffix(url)
        url_count[url] += 1
        link
      end
    end

    def url_suffix(url) = url_count[url].then { |count| count.zero? ? "" : count }
  end
end
