require "refinements/array_extensions"

module Tocer
  module Transformers
    # Transforms a Markdown header (plain text) into a table of contents link.
    class Text
      using Refinements::ArrayExtensions

      def initialize text, header: Parsers::Header
        @header = header.new text
      end

      def label
        header.content
      end

      def url
        label.downcase.gsub(/\s/, "-").gsub(/[^\w\-]+/, "")
      end

      def transform url_suffix: ""
        modified_url = [url, url_suffix.to_s].compress.join "-"
        "#{indented_bullet}[#{label}](##{modified_url})"
      end

      private

      attr_reader :header

      def prefix_to_spaces
        Array.new(header.prefix.length, "  ").join
      end

      def indented_bullet
        prefix_to_spaces.gsub(/\s{2}$/, "- ")
      end
    end
  end
end
