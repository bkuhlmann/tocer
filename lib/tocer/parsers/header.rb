# frozen_string_literal: true

module Tocer
  module Parsers
    # Represents a Markdown header.
    class Header
      PUNCTUATION = "#"

      def initialize markdown
        @markdown = markdown
      end

      def prefix = String(markdown[/#{PUNCTUATION}{1,}/o])

      def content = markdown[prefix.length + 1, markdown.length].strip

      private

      attr_reader :markdown
    end
  end
end
