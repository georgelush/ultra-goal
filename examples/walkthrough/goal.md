<!-- ILLUSTRATIVE SAMPLE — fabricated for documentation, not a real run. See README.md. -->

# Goal

## Objective
`taskcli list` supports a `--json` flag that prints tasks as a JSON array.

## Expected outcome
Running `taskcli list --json` prints valid JSON to stdout (one array of task
objects with `id`, `title`, `done`); plain `taskcli list` output is unchanged.

## Non-goals
- No JSON output for other subcommands (`add`, `done`).
- No output-format config file or environment variable.

## Constraints
- Node 18+, no new runtime dependencies (discovery answer: stack is imposed).
- Must not break the existing table output — downstream scripts parse it.
- Deadline: none stated by user.

## Discovery answers (recorded 2026-08-10)
- Observable outcome: `taskcli list --json | jq length` works.
- Technology/stack: Node 18 + commander, imposed by existing code.
- Existing setup: v0.3.2 published on npm, CI = GitHub Actions running `npm test` (vitest).
- Integrations: none — local JSON file storage only.
- Constraints: no new dependencies; keep table output byte-identical.
- Non-goals: see above; confirmed by user.

## Acceptance criteria
- [x] `taskcli list --json` prints valid JSON — verified by `node bin/taskcli list --json | jq . ` exiting 0
- [x] `taskcli list` table output unchanged — verified by existing snapshot test `list.test.js` passing
- [x] New test covers `--json` — `list-json.test.js` fails before implementation, passes after

## Open questions
- none
