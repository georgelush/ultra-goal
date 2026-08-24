# Evidence-backed architecture visuals

Use architecture views to answer concrete questions, not to decorate documentation.

## Separate truth states

Label every diagram and material node with one of:

- `CURRENT — VERIFIED`: supported by code, configuration, runtime evidence, or focused tests;
- `PROPOSED — NOT IMPLEMENTED`: selected design awaiting implementation;
- `IMPLEMENTED — VERIFIED`: implemented and verified after authorization;
- `UNKNOWN`: evidence is insufficient.

Never imply that a proposed component exists. Record evidence in `.ultra-goal/architecture/traceability.md`.

## Select useful views

Create the smallest set that explains the goal:

- system context: people, system boundary, and external systems;
- runtime: processes, services, workers, stores, queues, and calls;
- user journey: user-visible steps and outcomes;
- sequence: ordering, synchronous and asynchronous calls, and state changes;
- operations: deploy, observe, retry, recover, back up, and roll back;
- development: local change, test, review, CI, release, and feedback;
- data lifecycle: creation, validation, movement, storage, retention, and deletion;
- failure flow: timeouts, partial failure, retry, fallback, and operator action.

Mark irrelevant views `not applicable`; do not create empty boilerplate.

## Diagram rules

- Prefer Mermaid in Markdown so every provider can read and edit it.
- Give each diagram one question to answer.
- Use meaningful component and edge labels.
- Show system and trust boundaries where relevant.
- Pair visual status with text; never rely on color alone.
- Split a crowded diagram into separate perspectives.
- Keep current and proposed states in separate files.
- Do not invent throughput, latency, availability, or ownership.

## Trace evidence

For each material element record:

- status;
- code, symbol, configuration, test, command, or decision evidence;
- owner when known;
- assumptions;
- verification needed.

## Documentation lifecycle

Before implementation authorization, store visuals only under `.ultra-goal/architecture/`.

After implementation:

1. verify diagrams against actual code and behavior;
2. mark verified elements implemented;
3. record justified deviations;
4. place one compact overview in README only when useful;
5. integrate durable detailed views into existing architecture docs without duplication.
