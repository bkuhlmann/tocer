# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "tocer"
  spec.version = "14.3.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/tocer"
  spec.summary = "A command line interface for generating table of contents for Markdown files."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/tocer/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/tocer/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/tocer",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Tocer",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/tocer"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.1"
  spec.add_dependency "cogger", "~> 0.2"
  spec.add_dependency "dry-container", "~> 0.10"
  spec.add_dependency "refinements", "~> 9.6"
  spec.add_dependency "runcom", "~> 8.5"
  spec.add_dependency "spek", "~> 0.5"
  spec.add_dependency "zeitwerk", "~> 2.6"

  spec.bindir = "exe"
  spec.executables << "tocer"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
