<!-- ILLUSTRATIVE SAMPLE — fabricated for documentation, not a real run. See ../README.md. -->

# Claude analysis

updated_at: 2026-08-10T14:20:00+03:00
status: contributed

## Facts
- `src/list.js` already builds an array of task objects before formatting (`src/list.js:14`).
- Snapshot test pins the table output exactly (`test/list.test.js`).
- README claims JSON support that does not exist (audit: contradicted).

## Assumptions
- Users' scripts parse the table with `awk`; column order must not change.

## Proposed approach
Add `--json` option in `bin/taskcli`; in `src/list.js`, branch before
formatting: `JSON.stringify(tasks, null, 2)` when the flag is set. No new
dependencies.

## Alternatives considered
- Separate `taskcli export` subcommand: more surface, out of stated scope.
- `--format=json|table`: extensible but speculative; YAGNI.

## Risks and mitigations
- Snapshot test breakage: touch only the new branch; run snapshots unchanged.

## Challenges to existing proposals
- none (first analysis)

## Open questions
- Pretty-print or compact JSON? Recommend pretty (2 spaces) — pipe-friendly either way.

## Recommendation
Flag on `list` only, branch before formatting, test-first against the new
`list-json.test.js`.
