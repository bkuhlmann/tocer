# frozen_string_literal: true

require "tocer/identity"

module Tocer
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        def self.call(options: {}, client: CLIENT) = new(options: options, client: client).call

        def initialize options: {}, client: CLIENT
          @options = options
          @client = client
        end

        def call arguments = []
          client.banner = "#{Identity::LABEL} - #{Identity::SUMMARY}"
          client.separator "\nUSAGE:\n"
          collate
          arguments.empty? ? arguments : client.parse!(arguments)
        end

        private

        attr_reader :options, :client

        def collate
          private_methods.sort.grep(/add_/).each { |method| __send__ method }
        end

        def add_config
          client.on(
            "-c",
            "--config ACTION",
            %i[edit view],
            "Manage gem configuration: edit or view."
          ) do |action|
            options[:config] = action
          end
        end

        def add_build
          client.on "-b", "--build [PATH]", %(Build table of contents. Default path: ".") do |value|
            options[:build] = value || "."
          end
        end

        def add_version
          client.on "-v", "--version", "Show gem version." do
            options[:version] = Identity::VERSION_LABEL
          end
        end

        def add_help
          client.on "-h", "--help", "Show this message." do
            options[:help] = true
          end
        end
      end
    end
  end
end
