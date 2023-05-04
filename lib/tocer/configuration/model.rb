# frozen_string_literal: true

module Tocer
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Model = Struct.new :label, :root_dir, :patterns do
      def initialize(**)
        super
        self[:patterns] = Array patterns
      end
    end
  end
end
