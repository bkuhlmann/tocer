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
        transformers.find do |pattern, transformer|
          break transformer.new markdown if pattern.match? markdown
        end
      end

      private

      attr_reader :transformers
    end
  end
end
