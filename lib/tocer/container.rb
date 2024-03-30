# frozen_string_literal: true

require "cogger"
require "containable"
require "etcher"
require "runcom"
require "spek"

module Tocer
  # Provides a global gem container for injection into other objects.
  module Container
    extend Containable

    register :configuration do
      self[:defaults].add_loader(Etcher::Loaders::YAML.new(self[:xdg_config].active))
                     .then { |registry| Etcher.call registry }
    end

    register :defaults do
      Etcher::Registry.new(contract: Configuration::Contract, model: Configuration::Model)
                      .add_loader(Etcher::Loaders::YAML.new(self[:defaults_path]))
    end

    register(:input) { self[:configuration].dup }
    register(:defaults_path) { Pathname(__dir__).join("configuration/defaults.yml") }
    register(:xdg_config) { Runcom::Config.new "tocer/configuration.yml" }
    register(:specification) { Spek::Loader.call "#{__dir__}/../../tocer.gemspec" }
    register(:logger) { Cogger.new id: :tocer }
    register :kernel, Kernel
  end
end
