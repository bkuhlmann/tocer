# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents file patterns.
      class Pattern < Sod::Action
        include Import[:settings]

        description "Set file patterns."

        on %w[-p --patterns], argument: "[a,b,c]"

        default { Container[:settings].patterns }

        def call(patterns = nil) = settings.patterns = Array(patterns || default)
      end
    end
  end
end
