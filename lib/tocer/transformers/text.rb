# frozen_string_literal: true

require "refinements/arrays"

module Tocer
  module Transformers
    # Transforms a Markdown header (plain text) into a table of contents link.
    class Text
      using Refinements::Arrays

      def initialize text, parser: Parsers::Header
        @parser = parser.new text
      end

      def label
        parser.content
      end

      def url
        label.downcase.gsub(/\s/, "-").gsub(/[^\w\-]+/, "")
      end

      def call url_suffix: ""
        "#{indented_bullet}[#{label}](##{computed_url url_suffix})"
      end

      private

      attr_reader :parser

      def computed_url suffix = ""
        [url, suffix.to_s].compress.join "-"
      end

      def indented_bullet
        prefix_to_spaces.gsub(/\s{2}$/, "- ")
      end

      def prefix_to_spaces
        Array.new(parser.prefix.length, "  ").join
      end
    end
  end
end
