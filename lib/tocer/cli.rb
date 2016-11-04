# frozen_string_literal: true

require "yaml"
require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"

module Tocer
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Tocer::Identity.version_label

    def self.defaults
      {label: "# Table of Contents"}
    end

    def initialize args = [], options = {}, config = {}
      super args, options, config
      @configuration = Runcom::Configuration.new file_name: Tocer::Identity.file_name, defaults: self.class.defaults
    end

    desc "-g, [--generate=GENERATE]", "Generate table of contents."
    map %w[-g --generate] => :generate
    method_option :label, aliases: "-l", desc: "Custom label", type: :string, default: defaults.fetch(:label)
    def generate file_path
      Writer.new(file_path, label: compute_label(options[:label])).write
      say "Generated table of contents: #{file_path}."
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit, aliases: "-e", desc: "Edit gem configuration.", type: :boolean, default: false
    method_option :info, aliases: "-i", desc: "Print gem configuration info.", type: :boolean, default: false
    def config
      if options.edit? then `#{editor} #{configuration.computed_path}`
      elsif options.info? then say("Using: #{configuration.computed_path}.")
      else help(:config)
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Tocer::Identity.version_label
    end

    desc "-h, [--help=HELP]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    attr_reader :configuration

    def compute_label label
      configured_label = configuration.to_h.fetch :label
      label == self.class.defaults.fetch(:label) ? configured_label : label
    end
  end
end
