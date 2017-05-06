# frozen_string_literal: true

require "pathname"

module Tocer
  # Generates/updates Table of Contents for files in given path.
  class Runner
    def initialize path = ".", configuration: {}, writer: Writer
      @path = Pathname path
      @configuration = configuration
      @writer = writer
    end

    def files
      return [] unless path.exist? && path.directory? && !whitelist.empty?
      Pathname.glob(%(#{path}/{#{whitelist.join ","}})).select(&:file?)
    end

    def run
      files.each { |file| writer.new(file, label: configuration.fetch(:label)).write }
    end

    private

    attr_reader :path, :configuration, :writer

    def whitelist
      Array configuration[:whitelist]
    end
  end
end
