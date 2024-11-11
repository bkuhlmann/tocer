# frozen_string_literal: true

require "sod"

module Tocer
  module CLI
    module Actions
      # Stores table of contents label.
      class Label < Sod::Action
        include Dependencies[:settings]

        description "Set label."

        on %w[-l --label], argument: "[TEXT]"

        default { Container[:settings].label }

        def call(label = default) = settings.label = label
      end
    end
  end
end
