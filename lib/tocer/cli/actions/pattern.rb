# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents file patterns.
      class Pattern < Sod::Action
        include Import[:input]

        using Refinements::Structs

        description "Set file patterns."

        on %w[-p --patterns], argument: "[a,b,c]"

        default { Container[:configuration].patterns }

        def call(patterns = default) = input.merge! patterns: Array(patterns)
      end
    end
  end
end
