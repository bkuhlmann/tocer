# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the config action.
      class Config
        def initialize configuration: Configuration::Loader::CLIENT, kernel: Kernel
          @configuration = configuration
          @kernel = kernel
        end

        def call action
          case action
            when :edit then edit
            when :view then view
            else fail StandardError, "Invalid configuration action: #{action}."
          end
        end

        private

        attr_reader :configuration, :kernel

        def edit = kernel.system("$EDITOR #{configuration.current}")

        def view = kernel.system("cat #{configuration.current}")
      end
    end
  end
end
