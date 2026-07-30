#!/usr/bin/env bash
# ultra-goal opt-in PreToolUse hook (Claude Code).
# Blocks Edit/Write outside .ultra-goal/ while the project's
# .ultra-goal/state.md shows authorized_scope: none (or missing).
# Exit 0 = allow, exit 2 = block with message on stderr.

set -u

input=$(cat)

if command -v jq >/dev/null 2>&1; then
  file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
else
  file_path=$(printf '%s' "$input" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
fi

[ -z "$file_path" ] && exit 0

# Find the project root (nearest ancestor with .git) for the target file.
dir=$(dirname "$file_path")
root=""
while [ -n "$dir" ] && [ "$dir" != "/" ]; do
  if [ -e "$dir/.git" ]; then
    root="$dir"
    break
  fi
  dir=$(dirname "$dir")
done
[ -z "$root" ] && exit 0

state="$root/.ultra-goal/state.md"
[ -f "$state" ] || exit 0

# Writes inside .ultra-goal/ are always allowed.
case "$file_path" in
  "$root/.ultra-goal/"*) exit 0 ;;
esac

scope=$(sed -n 's/^authorized_scope:[[:space:]]*//p' "$state" | head -1)

if [ -z "$scope" ] || [ "$scope" = "none" ]; then
  echo "ultra-goal gate: implementation not authorized (authorized_scope: none in $state). Ask the user the explicit authorization question first, record the approval in state.md, then retry." >&2
  exit 2
fi

exit 0
