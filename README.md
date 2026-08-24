# Ultra Goal

**Plan, audit, debate, and implement complex goals safely — across sessions and across AI agents.**

Ultra Goal is a portable agent skill. It keeps investigation, architecture, multi-model debate, and implementation authorization in **Markdown files on disk** (`.ultra-goal/` in your project), so Claude, Codex, Grok, Cursor, or a human teammate can pick up the same work without relying on chat memory.

- **Repo:** https://github.com/georgelush/ultra-goal  
- **License:** MIT  
- **Works with:** Claude Code, Grok Build, Codex, Cursor, and any agent that can load a skill or follow a Markdown protocol

---

## Why use it?

AI agents are great at coding and bad at durable process:

| Problem without Ultra Goal | What Ultra Goal does |
|----------------------------|----------------------|
| Context dies when the chat ends | State lives in `.ultra-goal/` (git-friendly) |
| Agent starts coding before you agreed | **Authorization gate** — no implementation until you say `da` / `go` / `aproba` |
| Docs claim one thing, code does another | Project **audit** from real code, not README claims |
| Switching Claude → Codex → Grok loses the plan | Shared handoff files any provider can resume |
| “Done” means “agent said so” | Acceptance criteria need **evidence** (commands, tests, paths) |
| Architecture diagrams mix “now” and “wish” | Diagrams labeled `CURRENT`, `PROPOSED`, or `IMPLEMENTED` |

**Best for:** multi-session features, refactors with risk, multi-agent collaboration, or any goal where “just ship it” has burned you before.

**Overkill for:** one-line typo fixes and trivial single-file edits (use a lighter skill or just chat).

---

## How it works (30-second model)

```text
You  →  /ultra-goal "ship X"
Agent →  reads/writes only .ultra-goal/ until you authorize
      →  audit code + docs drift
      →  architecture visuals (labeled)
      →  debate / synthesis (optional multi-model)
You  →  "go" / "da" / "aproba" for a stated scope
Agent →  implements that scope only, with worklog evidence
You  →  confirm completion; handoff deleted or next goal starts
```

Project-local source of truth:

```text
your-project/
  .ultra-goal/
    goal.md           # what success looks like
    plan.md           # exactly one NEXT action
    state.md          # phase, tier, authorized_scope
    worklog.md        # append-only, evidence required
    project-audit.md  # code vs docs (lazy)
    decisions.md      # accepted / rejected choices
    debate/           # claude.md, codex.md, grok.md, synthesis.md
    ui/               # mockups only (never production before auth)
  src/ ...
```

**Git policy:** commit `.ultra-goal/` by default — handoff is the point. Gitignore only if the plan contains secrets.

---

## Install

### Claude Code — plugin (recommended)

```text
/plugin marketplace add georgelush/ultra-goal
/plugin install ultra-goal@ultra-goal
```

This installs the skill **and wires the enforcement hook automatically**: while
a project's `.ultra-goal/state.md` says `authorized_scope: none`, Edit/Write
outside `.ultra-goal/` is mechanically blocked. The hook is inert in projects
without `.ultra-goal/`. (Honest limits: Edit/Write tools only — see
[`hooks/README.md`](hooks/README.md).)

### Claude Code — manual (clone + copy)

macOS / Linux:

```bash
git clone https://github.com/georgelush/ultra-goal.git
mkdir -p ~/.claude/skills
# Copy (simple) or symlink (easy updates)
cp -R ultra-goal/skills/ultra-goal ~/.claude/skills/ultra-goal
# ln -s "$(pwd)/ultra-goal/skills/ultra-goal" ~/.claude/skills/ultra-goal
```

Windows (PowerShell):

```powershell
git clone https://github.com/georgelush/ultra-goal.git
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\skills" | Out-Null
Copy-Item -Recurse ultra-goal\skills\ultra-goal "$env:USERPROFILE\.claude\skills\ultra-goal"
```

Manual installs get the skill only; wire the hook yourself per
[`hooks/README.md`](hooks/README.md).

### Grok Build

```bash
git clone https://github.com/georgelush/ultra-goal.git
mkdir -p ~/.grok/skills
cp -R ultra-goal/skills/ultra-goal ~/.grok/skills/ultra-goal
```

(Use your Grok skills path if it differs.)

### Codex / Cursor / other agents

1. Clone this repo.
2. Put `skills/ultra-goal/` (contains `SKILL.md` + `references/`) where that product loads skills, **or** paste the protocol into project instructions and point the agent at `.ultra-goal/`.
3. Invoke with the same phrases below.

### Per-project (team share)

```powershell
# inside a product repo
git clone https://github.com/georgelush/ultra-goal.git vendor/ultra-goal
New-Item -ItemType Directory -Force .claude\skills | Out-Null
Copy-Item -Recurse vendor\ultra-goal\skills\ultra-goal .claude\skills\ultra-goal
# commit so teammates get the skill with the project
```

(macOS/Linux: same layout with `mkdir -p .claude/skills` + `cp -R`.)

### Update

```bash
cd path/to/ultra-goal
git pull
# if you used cp, re-copy skills/ultra-goal into your skills directory
```

Plugin installs update via `/plugin marketplace update ultra-goal`.

---

## Usage

### Start a goal

In an agent chat, from your project root:

```text
/ultra-goal Add offline sync for mobile clients with conflict resolution
```

or:

```text
$ultra-goal
```

(then describe the goal when asked)

or natural language:

```text
Start an ultra-goal: migrate auth to OAuth2 without downtime.
```

### Resume (same or different agent)

```text
/ultra-goal
```

or:

```text
Continue the ultra-goal / resume ultra-goal
```

The agent should read `state.md`, `goal.md`, `plan.md`, and the last worklog entries, then continue the single NEXT action.

### Tiers (how heavy the process is)

| Tier | When | What runs |
|------|------|-----------|
| **L** (default) | Complex / multi-session | Audit, docs sync duty, architecture views, full debate, UI workflow if relevant |
| **M** | Medium | Audit, decisions, short synthesis; diagrams only if structure changes |
| **S** | Small but still gated | `goal` / `plan` / `state` / `worklog` + one-page analysis |

Ask explicitly: “use tier M” / “tier S”.

### Authorization (implementation gate)

Until you approve, the agent may only:

- inspect the project (read-only)
- ask questions / debate
- write inside `.ultra-goal/`

It must **not** edit product source, tests, deps, git, deploy, etc.

When ready, it asks something like:

> Approve implementation of X (scope: Y)?

You authorize with a clear yes in the **next** message, for example:

- `da`
- `go`
- `aproba`
- `yes, implement`
- `start implement`

That answer is recorded in `state.md` and applies **only to that scope**.  
`pause implementation` revokes authorization.

### Multi-model debate

Each provider writes **only its own** file:

- `.ultra-goal/debate/claude.md`
- `.ultra-goal/debate/codex.md`
- `.ultra-goal/debate/grok.md`
- `.ultra-goal/debate/other.md`

Then a synthesis in `debate/synthesis.md`. Simulated “other side” opinions must be labeled simulated and never replace your approval.

### Completion

The agent does **not** self-declare victory. When acceptance checks have evidence, you confirm. Then either start the next goal or remove `.ultra-goal/` after a short ROADMAP note.

---

## Repository layout

```text
ultra-goal/
  README.md                 # this file
  LICENSE
  .claude-plugin/
    marketplace.json        # /plugin marketplace add georgelush/ultra-goal
    plugin.json             # plugin manifest; auto-wires the PreToolUse hook
  skills/
    ultra-goal/
      SKILL.md              # full protocol (what agents load)
      references/
        templates.md        # goal/plan/state/worklog/debate templates
        project-audit.md    # how to audit code vs docs
        architecture-visuals.md # labeled diagrams
        ui-design.md        # UI baseline + mockups under .ultra-goal/ui/
  agents/
    openai.yaml             # optional agent UI metadata
  hooks/
    check-authorization.sh  # Claude Code PreToolUse gate (auto with plugin)
    README.md               # manual install + honest limitations
  examples/
    walkthrough/            # ILLUSTRATIVE sample .ultra-goal/ (not a real run)
```

---

## Design principles (short)

1. **Evidence over claims** — code, config, tests, and command output beat README prose.
2. **No implementation without authorization** — chat-level gate, durable in `state.md`.
3. **One NEXT action** — no multi-page “maybe later” without a single next step.
4. **Append-only worklog** — every entry needs a path, command, test, or user quote.
5. **Provider-honest** — never invent another model’s participation or unrun checks.
6. **Handoff by default** — Markdown + git, not a proprietary session format.

Full rules live in [`SKILL.md`](skills/ultra-goal/SKILL.md). A complete
sample `.ultra-goal/` (clearly labeled illustrative) is in
[`examples/walkthrough/`](examples/walkthrough/).

---

## Hard enforcement (Claude Code)

Installed as a **plugin**, the PreToolUse gate is wired automatically — no
setup. Manual installs wire it per [`hooks/README.md`](hooks/README.md).

**Honest limits:** the hook blocks the Edit/Write tools only. Writes through
Bash (`echo > file`, `sed -i`, `git apply`) are **not** intercepted. The gate
is enforced convention that stops an agent forgetting the protocol — it is
not a sandbox or security boundary. Details in
[`hooks/README.md`](hooks/README.md).

Other harnesses (Codex, Grok, …) rely on the skill text only.

---

## FAQ

**Does this replace Git / PR review?**  
No. It structures planning and agent handoff. You still review code and use normal CI.

**Should `.ultra-goal/` be private?**  
Usually commit it. If it contains sensitive business strategy or secrets, gitignore or use a private branch.

**Can I use it without installing the skill?**  
Yes: drop `skills/ultra-goal/SKILL.md` into project docs and tell the agent to follow Ultra Goal and maintain `.ultra-goal/`. Installing as a skill or plugin is smoother.

**Is multi-model debate required?**  
No. One provider doing a thorough analysis is fine; label it analysis, not debate.

**Romanian / English?**  
Affirmatives like `da` / `aproba` are first-class. Write goals and worklogs in whatever language your team uses.

---

## Contributing

Issues and PRs welcome. Keep `SKILL.md` as the source of truth for agent behavior; keep this README human-oriented and short.

---

## License

[MIT](LICENSE) — free to use, copy, modify, and share.
