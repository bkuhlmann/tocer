# frozen_string_literal: true

require "dry/schema"
require "etcher"

Dry::Schema.load_extensions :monads

module Tocer
  module Configuration
    Contract = Dry::Schema.Params do
      required(:label).filled :string
      required(:patterns).array :string
      required(:root_dir).filled Etcher::Types::Pathname
    end
  end
end
