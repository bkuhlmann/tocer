# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "cli" => "CLI"
  loader.tag = File.basename __FILE__, ".rb"
  loader.ignore "#{__dir__}/tocer/rake"
  loader.push_dir __dir__
  loader.setup
end

# Main namespace.
module Tocer
end
