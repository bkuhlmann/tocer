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
