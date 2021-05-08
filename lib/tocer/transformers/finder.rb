# frozen_string_literal: true

module Tocer
  module Transformers
    # Finds appropriate header transformer for matching pattern.
    class Finder
      TRANSFORMERS = {/\[.+\]\(.+\)/ => Transformers::Link, /.*/ => Transformers::Text}.freeze

      def initialize transformers: TRANSFORMERS
        @transformers = transformers
      end

      def call markdown
        transformers.find { |pattern, transformer| break transformer if pattern.match? markdown }
                    .then { |transformer| transformer.new markdown }
      end

      private

      attr_reader :transformers
    end
  end
end
