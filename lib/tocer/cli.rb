# frozen_string_literal: true

require "thor"
require "thor/actions"
require "runcom"

module Tocer
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity.version_label

    def self.configuration
      Runcom::Configuration.new Identity.name, defaults: {
        label: "## Table of Contents",
        includes: ["README.md"]
      }
    end

    def initialize args = [], options = {}, config = {}
      super args, options, config
      @configuration = self.class.configuration
    rescue Runcom::Errors::Base => error
      abort error.message
    end

    desc "-g, [--generate=PATH]", "Generate table of contents."
    map %w[-g --generate] => :generate
    method_option :label,
                  aliases: "-l",
                  desc: "Label",
                  type: :string,
                  default: configuration.to_h.fetch(:label)
    method_option :includes,
                  aliases: "-i",
                  desc: "File include list",
                  type: :array,
                  default: configuration.to_h.fetch(:includes)
    # :reek:TooManyStatements
    def generate path = "."
      updated_configuration = configuration.merge label: options.label, includes: options.includes
      runner = Runner.new path, configuration: updated_configuration.to_h
      files = runner.files

      return if files.empty?

      runner.run

      say "Processed table of contents for:"
      files.each { |file| say "  #{file}" }
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean, default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean, default: false
    def config
      path = configuration.path

      if options.edit? then `#{ENV["EDITOR"]} #{path}`
      elsif options.info?
        path ? say(path) : say("Configuration doesn't exist.")
      else help(:config)
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity.version_label
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    attr_reader :configuration
  end
end
