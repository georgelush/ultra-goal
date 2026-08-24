# ultra-goal enforcement hook (Claude Code only)

`check-authorization.sh` is a PreToolUse hook that turns the skill's
authorization gate from convention into an actual block: while a project has
`.ultra-goal/state.md` with `authorized_scope: none`, any Edit/Write targeting
a file outside `.ultra-goal/` is rejected with a message telling the agent to
ask for authorization first.

Projects without `.ultra-goal/` are unaffected — the script exits 0 and is
inert. Writes inside `.ultra-goal/` are always allowed. Other harnesses
(Codex, Grok) cannot run this hook and rely on the skill's convention.

## Install

**Plugin install (recommended):** nothing to do. `.claude-plugin/plugin.json`
wires this hook automatically when the repo is installed with
`/plugin install ultra-goal@ultra-goal`.

**Manual install** (clone + copy setups):

1. Make it executable:

```bash
chmod +x path/to/ultra-goal/hooks/check-authorization.sh
```

2. Add to `~/.claude/settings.json` (global) or `<project>/.claude/settings.json`,
   pointing at the script inside your clone:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "path/to/ultra-goal/hooks/check-authorization.sh"
          }
        ]
      }
    ]
  }
}
```

## Limitations — read before trusting the gate

The hook intercepts the **Edit and Write tools only**. Writes that go through
Bash are **not** blocked:

```bash
echo "code" > src/file.js     # passes the gate
sed -i 's/a/b/' src/file.js   # passes the gate
git apply patch.diff          # passes the gate
```

The gate is enforced convention, not a sandbox. It stops an agent that
forgets the protocol; it cannot stop one that routes around it. Do not
present it as a security boundary — for hard isolation use OS-level
sandboxing or containers.

## Notes

- Requires `jq` for robust JSON parsing; falls back to a sed extraction
  without it.
- The hook checks only `authorized_scope` presence, not scope contents —
  scope compliance stays the agent's responsibility.
