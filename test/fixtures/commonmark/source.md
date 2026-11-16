# CommonMark conformance cases

The unmodified `spec.json` is the official CommonMark 0.31.2 corpus:

- Source: https://spec.commonmark.org/0.31.2/spec.json
- Specification: https://spec.commonmark.org/0.31.2/
- Upstream: https://github.com/commonmark/commonmark-spec/tree/0.31.2
- Cases: 652
- SHA-256: `d431b29d97b6f73e69d547109cf5081578fac931e72afe95639ebe766c1b2a20`

The examples originate in John MacFarlane's specification and retain their
upstream licence. See `LICENSE` beside this file, including its CC-BY-SA 4.0
notice for the specification. Marksy's Apache-2.0 licence does not replace it.

Each entry provides Markdown, expected HTML, example number, section, and
source line range. Compare generated HTML with upstream expected HTML exactly;
do not regenerate expected output from Marksy or accept it as a snapshot.

`corpus.spec.pooka` checks corpus integrity and its typed decoder. The
`commonmark_*.spec.pooka` files contain named exact-output tests for every
example. All 652 official examples currently pass without skips; see `progress.json`
and `docs/conformance.md` for coverage and scope.
