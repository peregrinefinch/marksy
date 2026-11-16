# marksy

[![Package Version](https://img.shields.io/hexpm/v/marksy?style=for-the-badge&color=75618E)](https://hex.pm/packages/marksy)
[![Hex Docs](https://img.shields.io/website?url=https%3A%2F%2Fmarksy.hexdocs.pm%2F&style=for-the-badge&label=hex&up_message=docs&up_color=FF891F&down_message=not%20found&down_color=lightgrey)](https://marksy.hexdocs.pm/)
[![Tests](https://img.shields.io/github/actions/workflow/status/peregrinefinch/marksy/test.yml?style=for-the-badge&label=tests)](https://github.com/peregrinefinch/marksy/actions/workflows/test.yml)

Markdown, HTML, and TOML front matter for Pooka. Metadata uses `---` delimiters.

## Installation

```sh
pooka add marksy
```

## Usage

```pooka
import marksy

main() {
  echo marksy.to_html("# Owl\n\nA *small* visitor.\n")
}
```

All 652 official CommonMark 0.31.2 examples pass. Tables, task lists, and
strikethrough are opt-in; their 13 official GFM examples pass too. Use the
[guide](docs/guide.md) for metadata, typed ASTs, extensions, HTML policies, and
resource-bounded parsing. [Conformance](docs/conformance.md) records the scope.

## Licence

[Apache-2.0](LICENSE). Entity data and specification fixtures retain their
original licences; see [third-party notices](docs/licences.md).
