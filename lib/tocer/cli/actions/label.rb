# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents label.
      class Label < Sod::Action
        include Import[:input]

        description "Set label."

        on %w[-l --label], argument: "[TEXT]"

        default { Container[:configuration].label }

        def call(label = nil) = input.label = label || default
      end
    end
  end
end
