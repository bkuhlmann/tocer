# frozen_string_literal: true

module Tocer
  module Elements
    # Represents a table of contents start and finish comment block.
    class CommentBlock
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

      def start_index collection
        index collection, start_id
      end

      def finish
        comment finish_id, message
      end

      def finish_index collection
        index collection, finish_id
      end

      private

      attr_reader :start_id, :finish_id, :message

      def comment id, message
        "<!-- #{id}: #{message} -->"
      end

      def index collection, id
        collection.index { |line| line =~ /\<\!\-\-.*#{Regexp.escape id}.*\-\-\>/ }
      end
    end
  end
end
