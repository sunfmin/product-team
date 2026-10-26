#!/bin/sh
# Exercise the hooks from an isolated role directory, as workers receive it.
set -eu
cd "$(dirname "$0")/.."
root=$PWD
scratch=$(mktemp -d "$root/.limits-test.XXXXXX")
trap 'rm -rf "$scratch"' EXIT HUP INT TERM

check_call() {
  command=$1
  expected=$2
  payload=$(jq -nc --arg command "$command" '{tool_name: "Bash", tool_input: {command: $command}}')
  status=0
  printf '%s\n' "$payload" | (cd "$scratch/role" && CLAUDE_PROJECT_DIR="$scratch/role" sh -c "$hook") >"$scratch/out" 2>"$scratch/err" || status=$?
  if [ "$status" -ne "$expected" ] || [ -s "$scratch/out" ]; then
    printf '%s/%s: %s: expected exit %s, got %s\n' "$role" "$harness" "$command" "$expected" "$status" >&2
    cat "$scratch/out" "$scratch/err" >&2
    exit 1
  fi
  if [ "$expected" -eq 2 ]; then
    test -s "$scratch/err"
  else
    test ! -s "$scratch/err"
  fi
}

for role in builder lead reviewer timekeeper; do
  rm -rf "$scratch/role"
  mkdir "$scratch/role"
  # No parent directory or sibling role is present in a worker's copy.
  cp -R "roles/$role/.claude" "roles/$role/.codex" "roles/$role/.kimi-code" "$scratch/role/"
  for harness in claude-code codex kimi; do
    case "$harness" in
      claude-code) config="$scratch/role/.claude/settings.json" ;;
      codex) config="$scratch/role/.codex/hooks.json" ;;
      kimi)
        # These roles use the builder's Kimi hook form, including its matcher.
        cmp "roles/builder/.kimi-code/limits.toml" "$scratch/role/.kimi-code/limits.toml"
        hook=$(sed -n 's/^command = //p' "$scratch/role/.kimi-code/limits.toml" | jq -er .)
        ;;
    esac
    if [ "$harness" != kimi ]; then
      hook=$(jq -er '[.hooks.PreToolUse[]? | select(.matcher == "Bash") | .hooks[] | select(.type == "command") | .command] | if length == 1 then .[0] else error("expected one Bash refusal hook") end' "$config")
    fi
    for command in \
      'git commit --no-verify -m test' \
      'git push --force origin HEAD' \
      'git push -f origin HEAD' \
      'git push -f' \
      'git push --force-with-lease origin HEAD' \
      'git rebase main' \
      'git -C /worktree rebase main'; do
      check_call "$command" 2
    done
    for command in \
      'git status --short' \
      'git commit -m test' \
      'git push origin HEAD' \
      'git push --follow-tags origin HEAD' \
      'git merge origin/main'; do
      check_call "$command" 0
    done
    printf 'limits: %s/%s refuses unsafe git and allows normal work\n' "$role" "$harness"
  done
done
