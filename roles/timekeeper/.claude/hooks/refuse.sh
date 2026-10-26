#!/bin/sh
# Refuses what a timekeeper never does, whatever it was asked: see CLAUDE.md.
call=$(cat)
case "$call" in
  *--no-verify*) echo "timekeeper: a commit is never made with --no-verify" >&2; exit 2 ;;
  *"push --force"*|*"push -f"*|*"push "*" --force"*|*"push "*" -f"*|*--force-with-lease*) echo "timekeeper: a branch is never force-pushed" >&2; exit 2 ;;
  *"git rebase"*|*"git -"*" rebase"*) echo "timekeeper: a branch is never rebased; merge instead" >&2; exit 2 ;;
esac
exit 0
