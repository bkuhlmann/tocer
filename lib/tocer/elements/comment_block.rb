# frozen_string_literal: true

module Tocer
  module Elements
    # Represents a table of contents start and finish comment block.
    class CommentBlock
      def self.index lines, id
        (lines.index { |line| line =~ /\<\!\-\-.*#{Regexp.escape id}.*\-\-\>/ }).to_i
      end

      def initialize start_id: "Tocer[start]",
                     finish_id: "Tocer[finish]",
                     message: "Auto-generated, don't remove."

        @start_id = start_id
        @finish_id = finish_id
        @message = message
      end

      def start
        comment start_id, message
      end

      def start_index lines
        self.class.index lines, start_id
      end

      def finish
        comment finish_id, message
      end

      def finish_index lines
        self.class.index lines, finish_id
      end

      private

      attr_reader :start_id, :finish_id, :message

      def comment id, message
        "<!-- #{id}: #{message} -->"
      end
    end
  end
end
