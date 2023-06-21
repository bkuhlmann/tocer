# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents file patterns.
      class Pattern < Sod::Action
        include Import[:input]

        description "Set file patterns."

        on %w[-p --patterns], argument: "[a,b,c]"

        default { Container[:configuration].patterns }

        def call(patterns = nil) = input.patterns = Array(patterns || default)
      end
    end
  end
end
