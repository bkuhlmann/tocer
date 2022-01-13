# frozen_string_literal: true

require "zeitwerk"

Zeitwerk::Loader.for_gem.then do |loader|
  loader.inflector.inflect "cli" => "CLI"
  loader.ignore "#{__dir__}/tocer/rake"
  loader.setup
end

# Main namespace.
module Tocer
end
