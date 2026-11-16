# Reading Markdown

Marksy implements CommonMark parsing in Pooka. All 652 official CommonMark
0.31.2 examples pass with exact expected HTML and no skipped cases. Selected GFM
extensions are opt-in; consult the conformance page for scope.

## Parse first, render second

```pooka
import marksy
import marksy/html

main() {
  let document = marksy.parse("# Owl\n\nA *small* visitor.\n")
  echo html.render(document)
}
```

The HTML is:

```html
<h1>Owl</h1>
<p>A <em>small</em> visitor.</p>
```

`marksy.to_html(source)` combines these two operations with safe defaults.
The tree exposes distinct block and inline classes, so a caller can inspect or
transform it before choosing a renderer. Block spans use original UTF-8 byte
offsets from zero, and line/column numbers from one. End positions are exclusive.
Inline nodes do not yet expose their own source spans.

## Read TOML front matter

```pooka
import marksy
import marksy/html

main() {
  let source = "---\ntitle = \"Owl\"\n---\n# Hello\n"
  let assert Ok(page) = marksy.read(source)
  echo page.metadata
  echo html.render(page.document)
}
```

`read` recognises exact `---` delimiter lines only at the beginning of input.
Metadata is TOML, not YAML. Missing closing delimiters or invalid TOML produce
a `FrontmatterError` whose line refers to the whole original document.

`marksy.parse` never extracts metadata: `---` in ordinary Markdown remains a
thematic break. `marksy/frontmatter.read` is available separately when a caller
only needs typed metadata and the unchanged body text.

## Choose a rendering policy

Defaults escape raw HTML and reject `javascript:`, `vbscript:`, and `data:`
destinations. Text, code, titles and attribute values are HTML-escaped, while
link destinations are percent-encoded. These policies do not turn the renderer
into a general-purpose HTML sanitiser.

For trusted input that intentionally contains HTML:

```pooka
let options = html.Options(html.RawHtml.Preserve, False)
let output = marksy.parse("A <b>small</b> owl.")
  |> html.render_with(options)
```

`RawHtml.Omit` drops recognised raw HTML nodes. `allow_unsafe_urls = true` also
permits unsafe destination schemes; CommonMark conformance tests select it
explicitly, applications ordinarily should not.

## Review rendering changes

Tests use Poke. The accepted rendered-page snapshot is in `test/snapshots/`:

```sh
pooka test --compact
pooka run -m poke review
```

Snapshot approval is for Marksy's application-level rendering tests. Official
CommonMark expected HTML remains upstream data and is never replaced through
snapshot acceptance.


## References and nested formatting

Definitions can follow their uses, including in nested block containers:

```pooka
let source = "# [Owl]\n\n[owl]: /birds/owl \"A visitor\"\n"
let html = marksy.to_html(source)
```

Reference labels collapse whitespace and use full Unicode case folding. The
first matching definition wins. Definitions do not appear as content in the
resolved tree. Direct links, collapsed references (`[owl][]`), full references
(`[bird][owl]`), and shortcuts (`[owl]`) share the same destination policy.

Emphasis uses Unicode-aware delimiter runs and CommonMark's rule of three.
Code spans, raw HTML, and link labels establish boundaries before those runs
are paired. Lists retain their own tightness, so a loose nested list does not
force paragraph wrappers onto its tight parent.

Named entities require semicolons. All 2,125 HTML names are available, including
values that contain multiple Unicode scalars. Numeric references use the HTML
replacement rules for invalid scalar values and legacy control references.


## Select extensions

CommonMark remains the default. Select tables, task lists, and strikethrough
with `marksy/syntax`; each flag can also be chosen independently.

```pooka
import marksy
import marksy/syntax

main() {
  let selected = syntax.gfm()
  echo marksy.to_html_with("- [x] Read the book\n- [ ] ~~Lose it~~\n", selected)
}
```

`syntax.Options(tables, task_lists, strikethrough)` selects individual features.
Task lists expose `ListItem.checked` as `Option(Bool)`; the renderer creates
fixed, disabled checkboxes without trusting raw HTML from the document. Table
nodes expose column alignments, header cells, and rows of inline content.

Escaped pipes stay inside table cells, including in code spans. Missing body
cells are empty and extra cells are discarded, as GFM specifies. A mismatched
header/delimiter column count remains ordinary Markdown.

`parse_with`, `to_html_with`, and `read_with` all accept these syntax options.
The selected features do not claim GFM's separate bare-autolink or disallowed-tag
extensions. HTML policy is still chosen independently through `html.Options`.

## Bound resource use

The direct `parse` and `to_html` functions run synchronously without budgets.
For input that needs a resource boundary, choose a checked entry point:

```pooka
import marksy
import marksy/html
import marksy/limits
import marksy/syntax

main() {
  let budget = limits.Budget(1048576, 20000000, 4000000, 5000)
  echo marksy.to_html_checked("# Owl", syntax.commonmark(), html.defaults(), budget)
}
```

The fields are maximum source bytes, BEAM reductions, worker heap words, and
elapsed milliseconds. `limits.defaults()` supplies the values above. Source
size is checked before spawning; work and heap are bounded in an isolated,
monitored worker. A timeout or work-budget cancellation kills and joins it
before returning. A failed worker is reported separately from a budget limit.

Reductions are runtime work units, not a nesting estimate. Work is polled and
heap limits are checked by the runtime during collection; these are BEAM
resource guards rather than an operating-system memory sandbox. They cover
deeply nested or delimiter-heavy input without pretending every small document
has a small parsing cost.

`parse_checked` returns a typed document. `to_html_checked` budgets both parsing
and rendering. `read_checked` also budgets TOML front matter and returns either
`MetadataError` or `ResourceError`, preserving the underlying typed error.

The worker is cancelled, but application side effects already performed by an
arbitrary `limits.run` callback cannot be undone. Ordinary Marksy parsing and
rendering callbacks are pure.
