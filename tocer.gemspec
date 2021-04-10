# frozen_string_literal: true

require_relative "lib/tocer/identity"

Gem::Specification.new do |spec|
  spec.name = Tocer::Identity::NAME
  spec.version = Tocer::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/tocer"
  spec.summary = Tocer::Identity::SUMMARY
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/tocer/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/tocer/changes.html",
    "documentation_uri" => "https://www.alchemists.io/projects/tocer",
    "source_code_uri" => "https://github.com/bkuhlmann/tocer"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.0"
  spec.add_dependency "refinements", "~> 8.0"
  spec.add_dependency "runcom", "~> 7.0"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "tocer"
  spec.require_paths = ["lib"]
end
