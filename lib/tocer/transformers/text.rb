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

      def label = parser.content

      def url = label.downcase.gsub(/\s/, "-").gsub(/[^\w-]+/, "")

      def call(url_suffix: "") = "#{indented_bullet}[#{label}](##{computed_url url_suffix})"

      private

      attr_reader :parser

      def computed_url(suffix = "") = [url, suffix.to_s].compress.join("-")

      def indented_bullet = prefix_to_spaces.gsub(/\s{2}$/, "- ")

      def prefix_to_spaces = Array.new(parser.prefix.length, "  ").join
    end
  end
end
