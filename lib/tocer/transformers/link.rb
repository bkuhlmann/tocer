module Tocer
  module Transformers
    # Transforms a Markdown header (embedded link) into a table of contents link.
    class Link
      def initialize text, header: Header
        @header = header.new text
      end

      def label
        header.content.gsub(embedded_link, embedded_link_label)
      end

      def url
        label.downcase.gsub(/\s/, "-").gsub(/[^\w\-]+/, "")
      end

      def transform
        "#{indented_bullet}[#{label}](##{url})"
      end

      private

      attr_reader :header

      def embedded_link_label
        header.content[/\[(.*)\]/, 1]
      end

      def embedded_link_url
        header.content[/\((.*)\)/, 1]
      end

      def embedded_link
        "[#{embedded_link_label}](#{embedded_link_url})"
      end

      def prefix_to_spaces
        Array.new(header.prefix.length, "  ").join
      end

      def indented_bullet
        prefix_to_spaces.gsub(/\s{2}$/, "- ")
      end
    end
  end
end
