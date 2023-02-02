# frozen_string_literal: true

require "core"
require "refinements/structs"

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        include Import[:specification]

        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize(configuration = Container[:configuration], client: Parser::CLIENT, **)
          super(**)
          @configuration = configuration
          @client = client
        end

        def call arguments = ::Core::EMPTY_ARRAY
          client.banner = specification.labeled_summary
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

        def add_insert
          root_dir = configuration.root_dir

          client.on(
            "-i",
            "--insert [PATH]",
            %(Insert/update table of contents. Default: "#{root_dir}".)
          ) do |path|
            configuration.merge! action_insert: true, root_dir: path || root_dir
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
