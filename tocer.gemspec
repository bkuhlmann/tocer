# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "tocer"
  spec.version = "19.2.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/tocer"
  spec.summary = "A command line interface for generating Markdown table of contents."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/tocer/issues",
    "changelog_uri" => "https://alchemists.io/projects/tocer/versions",
    "homepage_uri" => "https://alchemists.io/projects/tocer",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Tocer",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/tocer"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "cogger", "~> 1.0"
  spec.add_dependency "containable", "~> 1.1"
  spec.add_dependency "core", "~> 2.0"
  spec.add_dependency "dry-schema", "~> 1.13"
  spec.add_dependency "etcher", "~> 3.0"
  spec.add_dependency "infusible", "~> 4.0"
  spec.add_dependency "refinements", "~> 13.0"
  spec.add_dependency "runcom", "~> 12.0"
  spec.add_dependency "sod", "~> 1.0"
  spec.add_dependency "spek", "~> 4.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.bindir = "exe"
  spec.executables << "tocer"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
