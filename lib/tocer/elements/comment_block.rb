# frozen_string_literal: true

module Tocer
  module Elements
    # Represents a table of contents start and finish comment block.
    class CommentBlock
      def self.index lines, id
        (lines.index { |line| line =~ /<!--.*#{Regexp.escape id}.*-->/ }).to_i
      end

      def initialize start_id: "Tocer[start]",
                     finish_id: "Tocer[finish]",
                     message: "Auto-generated, don't remove."
        @start_id = start_id
        @finish_id = finish_id
        @message = message
      end

      def comments = "#{start_tag}\n#{finish_tag}\n"

      def start_index(lines) = self.class.index(lines, start_id)

      def start_tag = comment(start_id, message)

      def finish_index(lines) = self.class.index(lines, finish_id)

      def finish_tag = comment(finish_id, message)

      def empty?(lines) = (finish_index(lines) - start_index(lines)) == 1

      def prependable?(lines) = start_index(lines).zero? && finish_index(lines).zero?

      private

      attr_reader :start_id, :finish_id, :message

      def comment(id, message) = "<!-- #{id}: #{message} -->"
    end
  end
end
