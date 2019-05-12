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
      return [] unless path.exist? && path.directory? && !includes.empty?

      Pathname.glob(%(#{path}/{#{includes.join ","}})).select(&:file?)
    end

    def call
      files.each { |file| writer.new(file, label: configuration.fetch(:label)).call }
    end

    private

    attr_reader :path, :configuration, :writer

    def includes
      Array configuration[:includes]
    end
  end
end
