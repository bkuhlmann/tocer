# frozen_string_literal: true

require "refinements/arrays"

module Tocer
  module Transformers
    # Transforms a Markdown header (embedded link) into a table of contents link.
    class Link
      using Refinements::Arrays

      def initialize text, parser: Parsers::Header
        @parser = parser.new text
      end

      def label
        parser.content.gsub embedded_link, embedded_link_label
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

      def embedded_link
        "[#{embedded_link_label}](#{embedded_link_url})"
      end

      def embedded_link_label
        parser.content[/\[(.*)\]/, 1]
      end

      def embedded_link_url
        parser.content[/\((.*)\)/, 1]
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
