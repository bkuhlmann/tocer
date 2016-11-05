# v3.0.0 (2016-11-05)

- Fixed Rakefile to safely load Gemsmith tasks.
- Fixed calculation of label precedence.
- Added Runcom CLI configuration support.
- Added frozen string literal pragma.
- Updated CLI command option documentation.
- Updated README versioning documentation.
- Updated RSpec temp directory to use Bundler root path.
- Updated gemspec with conservative versions.
- Updated to Gemsmith 7.7.0.
- Updated to RSpec 3.5.0.
- Updated to Refinements 3.0.0.
- Updated to Rubocop 0.44.
- Updated to Ruby 2.3.1.
- Updated to Thor+ 4.0.0.
- Removed CHANGELOG.md (use CHANGES.md instead).
- Removed Rake console task.
- Removed `--edit` option (use `--config` instead).
- Removed gemspec description.
- Removed native configuration support in favor of Runcom.
- Removed rb-fsevent development dependency from gemspec.
- Removed terminal notifier gems from gemspec.
- Refactored RSpec spec helper configuration.
- Refactored gemspec to use default security keys.

# v2.2.0 (2016-04-24)

- Fixed README gem certificate install instructions.
- Fixed contributing guideline links.
- Added GitHub issue and pull request templates.
- Added Rubocop Style/SignalException cop style.
- Added bond, wirb, hirb, and awesome_print development dependencies.
- Updated GitHub issue and pull request templates.
- Updated README secure gem install documentation.
- Updated Rubocop PercentLiteralDelimiters and AndOr styles.
- Updated to Code of Conduct, Version 1.4.0.
- Removed gem label from CLI edit and version descriptions

# v2.1.0 (2016-01-20)

- Fixed secure gem install issues.
- Added Gemsmith development support.
- Added frozen string literals to Ruby source files.

# v2.0.0 (2016-01-17)

- Fixed README URLs to use HTTPS schemes where possible.
- Added IRB development console Rake task support.
- Added Rubocop Style/StringLiteralsInInterpolation cop.
- Updated to Ruby 2.3.0.
- Removed RSpec default monkey patching behavior.
- Removed Ruby 2.1.x and 2.2.x support.

# v1.0.0 (2015-11-21)

- Fixed CLI help command specs.
- Fixed comment block to index by ID only.
- Fixed gemspec homepage URL.
- Added CLI `--label` option to `--generate` command.
- Added Markdown header (embedded link) table of contents transformer.
- Added Markdown header (plain text) table of contents transformer.
- Added Markdown header parsing support.
- Added Refinements (gem) support.
- Added URL suffix support to transformers.
- Added URL uniqueness support to table of contents builder.
- Added configuration support.
- Added custom table of contents label support to `Writer`.
- Added transfomers to builder.
- Updated CLI with configuration.
- Updated README with Tocer generated Table of Contents.
- Removed Ruby 2.0.x support.
- Removed `Commenter` (replaced with `CommentBlock`).
- Removed ampersand (&) and plus (+) support from transformer.
- Removed transformer.
- Refactored `Header` to "Parsers" namespace.

# v0.1.0 (2015-11-15)

- Initial version.
