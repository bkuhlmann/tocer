# frozen_string_literal: true

require "runcom"

module Tocer
  module Configuration
    def self.default
      Runcom::Config.new Identity.name,
                         defaults: {
                           label: "## Table of Contents",
                           includes: ["README.md"]
                         }
    end
  end
end