# Changelog

## 1.1.0

- Run the test suite with Pooka stdlib 0.4.1.

## 1.0.0

Initial release.

- Add a native TOML front-matter reader with `---` delimiters and source offsets.
- Add Poke unit and property tests for front-matter extraction.
- Vendor the complete CommonMark 0.31.2 conformance corpus with provenance.
- Add typed corpus decoding and integrity checks.
- Add a native typed block/inline AST and a source-addressed Markdown parser.
- Render HTML with explicit raw-HTML and unsafe-URL policies.
- Parse headings, paragraphs, code blocks/spans, basic quotes and emphasis,
  inline links/images, autolinks, numeric entities and common named entities.
- Add 652 named official cases: 652 exact matches, no skipped cases.
- Add rendering snapshots and parser/renderer property and regression tests.

- Add ordered/unordered nested lists with empty items, marker-family boundaries,
  per-item indentation, and independent tight/loose rendering.
- Handle lazy block-quote and item continuations, including physical tab stops.
- Recognise all seven CommonMark HTML-block forms and their distinct endings.
- Cache lazy continuation state and reuse parsed item blocks for tightness checks.
- Add large-input, list structure, source-span, and raw-HTML policy regressions.

- Collect reference definitions across containers before resolving inline content.
- Add full, collapsed and shortcut references with first-definition precedence
  and Unicode case folding.
- Resolve nested emphasis through Unicode-aware delimiter runs and rule-of-three
  matching, preserving code/link boundaries.
- Include all 2,125 semicolon-terminated WHATWG named entities with their original
  licence notices and an independent corpus check.
- Preserve multiline code-span whitespace and fix lazy setext, inline declaration,
  CDATA, and escaped/entity-containing fence-info edge cases.
- Add reference, delimiter, entity, Unicode, and precedence regressions.

- Add opt-in tables, task list items, and strikethrough with all 13 official
  examples for those GFM extensions.
- Add checked parsing/rendering with source-byte, BEAM reduction, heap, and
  elapsed-time budgets, plus cancellation and adversarial-input regressions.
- Prepare documentation, three-platform CI, package metadata, and licence notices.
