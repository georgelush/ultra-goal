<!-- ILLUSTRATIVE SAMPLE — fabricated for documentation, not a real run. See README.md. -->

# Project reality audit

updated_at: 2026-08-10T14:05:00+03:00
status: complete-with-drift

## Sources inspected
- `bin/taskcli`: entry point, commander setup
- `src/list.js`: renders the task table
- `package.json`: scripts, dependencies
- `README.md`: documented usage

## Root structure
```text
taskcli/
├── bin/taskcli        # CLI entry (commander)
├── src/               # list.js, store.js, add.js, done.js
├── test/              # vitest, snapshot for list output
├── package.json       # no runtime deps beyond commander
└── README.md          # usage docs
```

## Actual architecture
- Entry points: `bin/taskcli` registers subcommands via commander (`bin/taskcli:12`)
- Main modules: `src/store.js` reads/writes `~/.taskcli.json`; `src/list.js` formats the table
- Important dependencies and contracts: commander ^12; table output parsed by users' scripts (constraint)
- Build, test, deployment: `npm test` (vitest), publish via `npm publish`, CI on push
- Existing UI and design system: not applicable (CLI)

## Documentation comparison
| Documented claim | Code evidence | Status | Required action |
|---|---|---|---|
| "Supports JSON output" (README, Features) | no `--json` handling anywhere in `src/` | contradicted | implement (this goal) or remove claim |
| "Zero dependencies" (README) | `commander` in `dependencies` | stale | fix README wording |
| `taskcli list` shows table | `src/list.js:20` | confirmed | none |

## Documentation plan
- README: update Features after implementation; fix "zero dependencies"
- ROADMAP: not applicable (none exists)
- docs/: not applicable

## Unknowns
- none material
