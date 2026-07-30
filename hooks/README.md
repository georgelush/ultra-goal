# ultra-goal enforcement hook (opt-in, Claude Code only)

`check-authorization.sh` is a PreToolUse hook that turns the skill's
authorization gate from convention into an actual block: while a project has
`.ultra-goal/state.md` with `authorized_scope: none`, any Edit/Write targeting
a file outside `.ultra-goal/` is rejected with a message telling the agent to
ask for authorization first.

Projects without `.ultra-goal/` are unaffected. Writes inside `.ultra-goal/`
are always allowed. Other harnesses (Codex, Grok) cannot run this hook and
rely on the skill's convention.

## Install

1. Make it executable:

```bash
chmod +x ~/.claude/skills/ultra-goal/hooks/check-authorization.sh
```

2. Add to `~/.claude/settings.json` (global) or `<project>/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/ultra-goal/hooks/check-authorization.sh"
          }
        ]
      }
    ]
  }
}
```

## Notes

- Requires `jq` for robust JSON parsing; falls back to a sed extraction
  without it.
- The hook checks only `authorized_scope` presence, not scope contents —
  scope compliance stays the agent's responsibility.
- Bash commands are not intercepted; this blocks the file-editing tools only.
