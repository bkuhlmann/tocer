# frozen_string_literal: true

require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"

module Tocer
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Identity.version_label

    def self.configuration
      Runcom::Configuration.new file_name: Identity.file_name, defaults: {
        label: "# Table of Contents",
        whitelist: %w[.md]
      }
    end

    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    desc "-g, [--generate=PATH]", "Generate table of contents."
    map %w[-g --generate] => :generate
    method_option :label,
                  aliases: "-l",
                  desc: "Label",
                  type: :string,
                  default: configuration.to_h.fetch(:label)
    method_option :whitelist,
                  aliases: "-w",
                  desc: "File whitelist",
                  type: :array,
                  default: configuration.to_h.fetch(:whitelist)
    def generate path = "."
      configuration = self.class.configuration.merge label: options.label,
                                                     whitelist: options.whitelist
      runner = Runner.new path, configuration: configuration
      files = runner.files

      return if files.empty?
      runner.run

      say "Processed table of contents for:"
      files.each { |file| say "  #{file}" }
    end

    desc "-c, [--config]", %(Manage gem configuration ("#{configuration.computed_path}").)
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
      path = self.class.configuration.computed_path

      if options.edit? then `#{editor} #{path}`
      elsif options.info? then say(path)
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
  end
end
