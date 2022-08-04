# frozen_string_literal: true

require "dry/container"

module Tocer
  module CLI
    module Actions
      # Provides a single container with application and action specific dependencies.
      module Container
        extend Dry::Container::Mixin

        merge Tocer::Container

        register(:config) { Config.new }
        register(:insert) { Insert.new }
      end
    end
  end
end
