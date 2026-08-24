<!-- ILLUSTRATIVE SAMPLE — fabricated for documentation, not a real run. See ../README.md. -->

# Debate synthesis

updated_at: 2026-08-10T17:00:00+03:00
status: ready-for-approval

## Contributors
- claude: debate/claude.md (contributed)
- codex: debate/codex.md (contributed)

## Shared conclusions
- `--json` flag on `list` only; branch in `src/list.js` before formatting; no new dependencies.
- Test-first: `list-json.test.js` written and shown failing before implementation.

## Unresolved disagreements
- none

## Alternatives and trade-offs
| Alternative | Benefits | Costs and risks | Verdict |
|---|---|---|---|
| `--json` flag on `list` | minimal surface, matches goal | none identified | selected |
| `export` subcommand | separable | scope creep | rejected |
| `--format=` option | extensible | speculative | rejected |

## Recommended approach
Add `--json` to the `list` command; when set, print `JSON.stringify(tasks, null, 2)`
and skip table formatting. Pin `Date` fields as ISO strings in the new test.

## Why this approach
Smallest change satisfying every acceptance criterion; leaves table path untouched
(snapshot test is the guard).

## Reality baseline
README currently claims JSON support that does not exist and "zero dependencies"
despite commander (audit 2026-08-10, complete-with-drift).

## Risks and mitigations
- Snapshot breakage: only the new branch touches `list.js`; snapshots must pass unchanged.

## Implementation sequence
1. Write `test/list-json.test.js`; run it; record the failure.
2. Implement flag + branch.
3. Run full test suite; record output.
4. Update README (Features, dependencies wording) — inside authorized scope.

## Acceptance checks
- [ ] `node bin/taskcli list --json | jq .` exits 0
- [ ] `npm test` fully green, snapshots unchanged
- [ ] `list-json.test.js` seen failing before implementation

## Documentation deliverables
- README: fix "zero dependencies"; document `--json` and date format
- ROADMAP: not applicable
- docs/: none

## Remaining questions
- none

## Approval gate
Implementation remains forbidden until the user gives a clear affirmative to
the explicit authorization question (see the skill's authorization gate).
