# Conformance

Marksy passes all **652 official CommonMark 0.31.2 examples**, comparing exact
expected HTML without skips or changed expectations. The pinned corpus and its
licence are in `test/fixtures/commonmark/`; `source.md` records its origin and
checksum. `progress.json` records all example IDs, with an empty pending list.

The three supported opt-in GFM extensions pass their **13 official examples**:
eight tables, two task-list examples, and three strikethrough examples from
GFM 0.29-gfm. Their extracted fixtures and provenance are in `test/fixtures/gfm/`.
This does not claim the separate GFM bare-autolink or disallowed-HTML extensions.

The complete HTML named-entity lookup is checked independently against all
**2,125 semicolon-terminated WHATWG names**, including multi-scalar values.
Its source table and licence are in `test/fixtures/entities/`.

Run `pooka test --compact`. Unit, property, snapshot, source-location, and
adversarial-input tests run alongside the official cases. Passing a finite
corpus is useful evidence, not a proof for every possible input. Adversarial regressions additionally exercise
nesting, unmatched delimiters, worker termination, and subsequent parser calls.

CommonMark examples select raw HTML preservation and unrestricted destinations.
Application defaults escape raw HTML and restrict unsafe schemes. Marksy is not
an HTML sanitiser. Checked APIs add source-byte, work, heap, and time budgets;
ordinary parsing remains direct. Block nodes carry source spans; inline nodes
do not yet carry individual spans.
