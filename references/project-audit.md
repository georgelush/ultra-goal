# Project reality and documentation audit

Use this workflow during discovery, whenever implementation changes structure, behavior, commands, contracts, or the root tree, and again before completion. Docs sync is a standing duty of the skill, not a completion step.

## Discover

1. Locate the project root and inspect Git status without changing it.
2. Read applicable instruction files first, including `AGENTS.md`, `CLAUDE.md`, and nested equivalents.
3. Discover root documentation such as `README*`, `ROADMAP*`, `CONTRIBUTING*`, `SECURITY*`, and architecture files.
4. Inspect indexes and relevant files under `docs/`; do not load every large document without purpose.
5. Inspect the one-level root structure, workspace and dependency manifests, build configuration, entry points, source boundaries, tests, deployment files, and operational configuration.
6. Exclude dependencies, generated output, caches, binaries, vendored code, and secret-value files from broad reading.

## Establish reality

- Derive architecture from code paths, imports, configuration, executable entry points, and tests.
- Distinguish implemented, partially implemented, planned, dead, generated, and duplicated components.
- Verify reuse claims. Similar names or duplicated folders do not prove shared ownership or shared behavior.
- Treat passing tests as evidence only for behavior they actually cover.
- Record file paths, symbols, commands, or test results supporting each important conclusion.

## Compare documentation

For every material claim, classify it as:

- `confirmed`: evidence matches;
- `stale`: formerly plausible but no longer current;
- `contradicted`: evidence conflicts;
- `unknown`: insufficient evidence.

Record the comparison in `.ultra-goal/project-audit.md`. Do not silently correct uncertainty.

## Plan documentation

### README

Keep README as the project index:

- purpose and current scope;
- essential requirements, setup, run, and test commands;
- short architecture summary;
- one-level root tree with concise purpose comments;
- links to detailed documentation.

Do not turn README into exhaustive module documentation.

### Detailed docs

Create or update only durable, important, non-obvious documentation, such as:

- architecture boundaries and significant decisions;
- unusual workflows or invariants;
- public APIs, data contracts, and migrations;
- deployment, operations, recovery, and troubleshooting;
- conventions that cannot be understood safely from code alone.

Follow the existing docs structure when sound. Avoid duplicated explanations.

### ROADMAP

Treat ROADMAP as intent, not evidence. Do not mark work implemented without code or verification evidence. Update it only when the goal changes actual milestone status or future direction.

## Enforce the gate

Before implementation authorization, write findings only inside `.ultra-goal/`. README, ROADMAP, and docs changes are implementation: report drift to the user and apply documentation updates only after the user confirms (typically with "update docs") or when they are already inside the authorized scope.

## Verify completion

Repeat the comparison after implementation. Confirm:

- README commands and structure match the repository;
- architecture descriptions match current boundaries;
- links resolve;
- completed ROADMAP claims have evidence;
- important new behavior, contracts, and operations are documented;
- no unexplained material drift remains.
