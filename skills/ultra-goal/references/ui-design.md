# Simple-first UI design

Use this workflow only when the goal creates or changes a user-facing interface.

## Establish context

Determine:

- target users and their primary job;
- critical user journey and success outcome;
- platform, input modes, devices, and responsive requirements;
- existing design system, brand, components, content style, and navigation;
- accessibility, localization, privacy, security, and performance constraints;
- engineering capacity and delivery constraints.

Inspect the real UI when available. Separate current behavior from documentation and assumptions.

## Apply design priorities

Use this order:

1. task completion and correctness;
2. simplicity and information hierarchy;
3. accessibility and inclusive interaction;
4. consistency with product and platform;
5. responsive behavior and performance;
6. maintainability and implementation cost;
7. current visual trends.

Use one primary action per focused screen when possible. Prefer progressive disclosure over presenting every option at once. Remove decoration without a user or communication purpose.

## Research current guidance

Do not hardcode a trend as permanently current. When current UI expectations materially affect the decision:

- consult current official platform, accessibility, or design-system guidance;
- inspect relevant contemporary product patterns;
- record source, publication or access date, applicability, and limitations in `ui/brief.md`;
- reject trends that reduce clarity, accessibility, consistency, performance, or product fit.

## Explore and debate

1. Map the shortest valid user flow.
2. Produce a low-fidelity wireframe first.
3. Produce two variants only when they represent a meaningful trade-off.
4. Compare task speed, clarity, hierarchy, navigation, states, accessibility, responsiveness, consistency, engineering effort, performance, and maintenance.
5. Record the decision and rejected alternative.
6. Create a static HTML mockup after the structure is chosen.

## Cover interface states

Address relevant:

- initial and empty;
- loading and progress;
- success and confirmation;
- validation and recoverable error;
- unavailable or offline;
- permission denied and authentication;
- destructive confirmation and undo;
- long content, small screen, keyboard, focus, and reduced motion.

Do not fabricate data or backend behavior. Label mockups as proposed.

## Mockup rules

- Keep mockups under `.ultra-goal/ui/` before authorization.
- Use semantic, responsive HTML and CSS without production backend calls or secrets.
- Reuse the project's visual language when sound.
- Keep essential labels visible and interactions understandable.
- Render and inspect the mockup with an available browser when possible; otherwise record that visual verification remains pending.
- Use generated images only as optional visual direction, never as the implementation specification.
- Record unresolved behavior in `ui/decisions.md`.

## Implement and verify

After implementation authorization:

1. implement against the approved user flow and decisions;
2. reuse established components and tokens;
3. test relevant states, keyboard use, responsive layouts, and accessibility;
4. compare rendered UI with the approved mockup;
5. update durable UI documentation only when it carries important non-obvious knowledge;
6. return to debate and renew approval for material changes in flow or structure.
