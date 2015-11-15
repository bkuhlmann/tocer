module Tocer
  # Represents table of contents start and finish comments.
  class Commenter
    def initialize start_id: "Tocer[start]", finish_id: "Tocer[finish]", message: "Auto-generated, don't remove."
      @start_id = start_id
      @finish_id = finish_id
      @message = message
    end

    def start
      comment start_id, message
    end

    def start_index collection
      index collection, start
    end

    def finish
      comment finish_id, message
    end

    def finish_index collection
      index collection, finish
    end

    private

    attr_reader :start_id, :finish_id, :message

    def comment id, message
      "<!-- #{id}: #{message} -->"
    end

    def index collection, text
      collection.index { |line| line =~ /#{Regexp.escape text}/ }
    end
  end
end
