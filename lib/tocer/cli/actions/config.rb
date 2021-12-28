# frozen_string_literal: true

module Tocer
  module CLI
    module Actions
      # Handles the config action.
      class Config
        def initialize client: Configuration::Loader::CLIENT, kernel: Kernel
          @client = client
          @kernel = kernel
        end

        def call action
          case action
            when :edit then edit
            when :view then view
            else kernel.puts "Invalid configuration action: #{action}."
          end
        end

        private

        attr_reader :client, :kernel

        def edit = kernel.system("$EDITOR #{client.current}")

        def view = kernel.system("cat #{client.current}")
      end
    end
  end
end
