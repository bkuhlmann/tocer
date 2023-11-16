# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "tocer"
  spec.version = "16.2.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/tocer"
  spec.summary = "A command line interface for generating Markdown table of contents."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/tocer/issues",
    "changelog_uri" => "https://alchemists.io/projects/tocer/versions",
    "documentation_uri" => "https://alchemists.io/projects/tocer",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Tocer",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/tocer"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = [">= 3.2", "<= 3.3"]
  spec.add_dependency "cogger", "~> 0.12"
  spec.add_dependency "core", "~> 0.1"
  spec.add_dependency "dry-container", "~> 0.11"
  spec.add_dependency "dry-schema", "~> 1.13"
  spec.add_dependency "etcher", "~> 0.2"
  spec.add_dependency "infusible", "~> 2.2"
  spec.add_dependency "refinements", "~> 11.0"
  spec.add_dependency "runcom", "~> 10.0"
  spec.add_dependency "sod", "~> 0.0"
  spec.add_dependency "spek", "~> 2.0"
  spec.add_dependency "zeitwerk", "~> 2.6"

  spec.bindir = "exe"
  spec.executables << "tocer"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
