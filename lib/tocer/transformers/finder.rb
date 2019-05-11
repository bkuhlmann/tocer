# frozen_string_literal: true

module Tocer
  module Transformers
    # Finds appropriate header transformer for matching pattern.
    class Finder
      TRANSFORMERS = {
        /\[.+\]\(.+\)/ => Transformers::Link,
        /.*/ => Transformers::Text
      }.freeze

      def self.call markdown
        TRANSFORMERS.find { |pattern, transformer| break transformer if pattern.match? markdown }
                    .then { |transformer| transformer.new markdown }
      end
    end
  end
end
