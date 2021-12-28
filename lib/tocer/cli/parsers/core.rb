# frozen_string_literal: true

require "tocer/identity"
require "refinements/structs"

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Configuration::Loader.call, client: Parser::CLIENT
          @configuration = configuration
          @client = client
        end

        def call arguments = []
          client.banner = "#{Identity::LABEL} - #{Identity::SUMMARY}"
          client.separator "\nUSAGE:\n"
          collate
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client

        def collate = private_methods.sort.grep(/add_/).each { |method| __send__ method }

        def add_config
          client.on(
            "-c",
            "--config ACTION",
            %i[edit view],
            "Manage gem configuration: edit or view."
          ) do |action|
            configuration.merge! action_config: action
          end
        end

        def add_build
          client.on "-b", "--build [PATH]", %(Build table of contents. Default path: ".".) do |path|
            configuration.merge! action_build: true, build_path: path || "."
          end
        end

        def add_version
          client.on "-v", "--version", "Show gem version." do
            configuration.merge! action_version: true
          end
        end

        def add_help
          client.on "-h", "--help", "Show this message." do
            configuration.merge! action_help: true
          end
        end
      end
    end
  end
end
