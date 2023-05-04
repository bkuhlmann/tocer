# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents label.
      class Label < Sod::Action
        include Import[:inputs]

        using Refinements::Structs

        description "Set label."

        on %w[-l --label], argument: "[TEXT]"

        default { Container[:configuration].label }

        def call(label = default) = inputs.merge!(label:)
      end
    end
  end
end
