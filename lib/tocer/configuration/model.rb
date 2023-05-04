# frozen_string_literal: true

module Tocer
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Model = Struct.new(
      :action_config,
      :action_help,
      :action_insert,
      :action_version,
      :includes,
      :label,
      :root_dir
    ) do
      def initialize **keywords
        super
        freeze
      end
    end
  end
end
