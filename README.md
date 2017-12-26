# Tocer

[![Gem Version](https://badge.fury.io/rb/tocer.svg)](http://badge.fury.io/rb/tocer)
[![Code Climate Maintainability](https://api.codeclimate.com/v1/badges/5d4db0f578703d8124a4/maintainability)](https://codeclimate.com/github/bkuhlmann/tocer/maintainability)
[![Code Climate Test Coverage](https://api.codeclimate.com/v1/badges/5d4db0f578703d8124a4/test_coverage)](https://codeclimate.com/github/bkuhlmann/tocer/test_coverage)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/tocer.svg)](https://gemnasium.com/bkuhlmann/tocer)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/tocer.svg?style=svg)](https://circleci.com/gh/bkuhlmann/tocer)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

Tocer (a.k.a. Table of Contenter) is a command line interface for generating table of contents for
Markdown files.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

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

## Features

- Supports Markdown ATX-style headers. Example: `# Header`.
    - Does not support header suffixes. Example: `# Header #`.
    - Does not support header prefixes without spaces. Example: `#Header`.
- Supports table of contents generation for single or multiple files.
- Supports custom label. Default: "## Table of Contents".
- Supports whitelist filtering. Default: "README.md".
- Prepends table of contents to Markdown documents that don't have table of contents.
- Rebuilds Markdown documents that have existing table of contents.

## Requirements

0. A UNIX-based system.
0. [Ruby 2.4.x](https://www.ruby-lang.org).

## Setup

Type the following to install:

    gem install tocer

## Usage

### Command Line Interface (CLI)

From the command line, type: `tocer --help`

    tocer -c, [--config]         # Manage gem configuration.
    tocer -g, [--generate=PATH]  # Generate table of contents.
    tocer -h, [--help=COMMAND]   # Show this message or get help for a command.
    tocer -v, [--version]        # Show gem version.

For specific `--generate` options, run `tocer --help --generate` to see the following:

    -l, [--label=LABEL]              # Label
                                     # Default: # Table of Contents
    -w, [--whitelist=one two three]  # File whitelist
                                     # Default: ["README.md"]

To generate the table of contents at a specific position within your Markdown files, add the
following lines to your file(s) prior to generation:

```
<!-- Tocer[start] -->
<!-- Tocer[finish] -->
```

Alternatively, you can run `tocer -g <directory>` on files that do not have Tocer support and it
will prepend the table of contents to your file(s), complete with an auto-generated table of
contents.

In the case that Tocer has already auto-generated a table of contents for a Markdown file, the
existing table of contents has become stale, or placement of the table of contents has changed you
can re-run Tocer on that file to auto-update it with new table of contents.

### Customization

This gem can be configured via a global configuration:

    ~/.config/tocer/configuration.yml

It can also be configured via [XDG environment variables](https://github.com/bkuhlmann/runcom#xdg)
as provided by the [Runcom](https://github.com/bkuhlmann/runcom) gem.

The default configuration is as follows:

    :label: "## Table of Contents"
    :whitelist: ["README.md"]

Feel free to take this default configuration, modify, and save as your own custom
`configuration.yml`.

The `configuration.yml` file can be configured as follows:

- `label`: The header label for the table of contents. Default: "# Table of Contents".
- `whitelist`: The list of *included* files. Default: "*.md".

There are multiple ways the *whitelist* can be defined. Here are some examples:

    # Use an empty array to ignore all files (a key with with no value would work too).
    :whitelist: []

    # Use an array of wildcards for groups of files with similar extensions:
    :whitelist:
      - *.md
      - *.mkd
      - *.markdown

    # Use a mix of wild cards and relative names/paths to customized as necessary:
    :whitelist:
      - README.md
      - docs/*.md
      - *.markdown

    # Use a recursive glob to traverse and update all sub-directories:
    :whitelist:
      - **/*.md

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright (c) 2015 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
