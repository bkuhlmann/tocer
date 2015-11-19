module Tocer
  module Transformers
    # Transforms a Markdown header (plain text) into a table of contents link.
    class Text
      def initialize text, header: Header
        @header = header.new text
      end

      def label
        header.content
      end

      def url
        label.downcase.gsub(/\s/, "-").gsub(/[^\w\-]+/, "")
      end

      def transform
        "#{indented_bullet}[#{label}](##{url})"
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
