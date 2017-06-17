# v6.0.0 (2017-06-17)

- Fixed bug with prepended TOC adding trailing spaces.
- Fixed spec description.
- Added Circle CI support.
- Added comment block prependability.
- Updated README usage configuration documenation.
- Updated builder to forward helpful methods to comment block.
- Updated gem dependencies.
- Updated label to be indented.
- Updated to Runcom 1.1.0.
- Removed Travis CI support.
- Refactored builder to build lines.
- Refactored comment block start and finish tags.
- Refactored fixtures.
- Refactored writer to use builder updates.

# v5.0.0 (2017-05-06)

- Fixed (partial) Reek issues.
- Fixed Rubocop Style/AutoResourceCleanup issues.
- Fixed Travis CI configuration to not update gems.
- Fixed comment block index calculation.
- Fixed whitelist wildcard usage.
- Added code quality Rake task.
- Added default path for table of content generation.
- Updated Guardfile to always run RSpec with documentation format.
- Updated README semantic versioning order.
- Updated RSpec configuration to output documentation when running.
- Updated RSpec spec helper to enable color output.
- Updated Rubocop configuration.
- Updated Rubocop to import from global configuration.
- Updated contributing documentation.
- Updated default whitelist to: `"README.md"`.
- Updated gem dependencies.
- Updated to Gemsmith 9.0.0.
- Updated to Ruby 2.4.1.
- Removed Code Climate code comment checks.
- Removed `.bundle` directory from `.gitignore`.
- Removed file path support from `--generate` option.
- Refactored comment block collection as lines.

# v4.0.0 (2017-01-22)

- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Rubocop Style/Documentation check.

# v3.3.0 (2016-12-18)

- Fixed README overview description typo.
- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.

# v3.2.0 (2016-12-03)

- Fixed frozen string issue with prepending of table of contents.
- Fixed issue with code comments showing up in table of contents.
- Added `--generate` deprecation warning when using file paths.
- Added `Gemfile.lock` to `.gitignore`.
- Added multi-file table of content generation support.
- Added table of contents runner.
- Updated Travis CI configuration to rely fully on defaults.
- Updated to Ruby 2.3.3.
- Refactored header punctuation to be a constant.

# v3.1.1 (2016-11-13)

- Fixed gem requirements order.

# v3.1.0 (2016-11-13)

- Fixed Ruby pragma.
- Added Code Climate engine support.
- Added Reek support.
- Updated `--config` command to use computed path.
- Updated gem dependencies.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Gemsmith 8.0.0.
- Removed CLI defaults (using configuration instead).
- Refactored source requirements.

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
