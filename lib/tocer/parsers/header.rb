# frozen_string_literal: true

module Tocer
  module Parsers
    # Represents a Markdown header.
    class Header
      def self.punctuation
        "#"
      end

      def initialize markdown
        @markdown = markdown
      end

      def prefix
        String markdown[/#{self.class.punctuation}{1,}/]
      end

      def content
        markdown[prefix.length + 1, markdown.length].strip
      end

      private

      attr_reader :markdown
    end
  end
end
