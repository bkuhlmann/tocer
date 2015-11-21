# Tocer

[![Gem Version](https://badge.fury.io/rb/tocer.svg)](http://badge.fury.io/rb/tocer)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/tocer.svg)](https://codeclimate.com/github/bkuhlmann/tocer)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/tocer/coverage.svg)](https://codeclimate.com/github/bkuhlmann/tocer)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/tocer.svg)](https://gemnasium.com/bkuhlmann/tocer)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/tocer.svg)](http://travis-ci.org/bkuhlmann/tocer)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

Tocer (a.k.a. Table of Contenter) is command line interface for generating table of contents for Markdown files.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
  - [Command Line Interface (CLI)](#command-line-interface-cli)
  - [Customization](#customization)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features

- Supports Markdown ATX-style headers. Example: `# Header`.
    - Does not support header suffixes. Example: `# Header #`.
    - Does not support header prefixes without spaces. Example: `#Header`.
- Prepends table of contents to Markdown documents that don't have table of contents.
- Replaces/updates Markdown documents that have existing table of contents.

# Requirements

0. A UNIX-based system.
0. [MRI 2.x.x](http://www.ruby-lang.org).

# Setup

For a secure install, type the following (recommended):

    gem cert --add <(curl -Ls http://www.my-website.com/gem-public.pem)
    gem install tocer --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install tocer

# Usage

## Command Line Interface (CLI)

From the command line, type: `tocer help`

    tocer -e, [--edit]               # Edit Tocer settings in default editor.
    tocer -g, [--generate=GENERATE]  # Generate table of contents.
    tocer -h, [--help=HELP]          # Show this message or get help for a command.
    tocer -v, [--version]            # Show Tocer version.

To add Tocer support, add the following at the correct position within your Markdown files:

```
<!-- Tocer[start] -->
<!-- Tocer[finish] -->
```

Alternatively, you can run `tocer -g <file_path>` on a file that does not have Tocer support and it will prepend the above
to your file, complete with an auto-generated table of contents.

In the case that Tocer has already auto-generated a table of contents for a Markdown file, the existing table of
contents has become stale, or placement of the table of contents has changed you can re-run Tocer on that file to auto-
update it with new table of contents.

## Customization

If desired, this gem supports global customization via the `~/.tocerrc` file. Order of precedence is determined in the
following order (with the last one taking top priority):

0. Global `~/.tocerrc`.
0. CLI option. Example: `tocer --generate README.md --label "Custom Label"`

Any setting provided to the CLI during runtime would trump the global setting. The global setting is the weakest of all
but great for situations where custom settings should be applied to *all* projects.

The `~/.tocerrc` uses the following default settings:

    :label: "# Table of Contents"

Each `~/.tocerrc` setting can be configured as follows:

- `label`: The header label for the table of contents. Default: "# Table of Contents".

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2015 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).
