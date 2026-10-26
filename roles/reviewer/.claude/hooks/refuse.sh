#!/bin/sh
# Refuses what a reviewer never does, whatever it was asked: see CLAUDE.md.
call=$(cat)
case "$call" in
  *--no-verify*) echo "reviewer: a commit is never made with --no-verify" >&2; exit 2 ;;
  *"push --force"*|*"push -f"*|*"push "*" --force"*|*"push "*" -f"*|*--force-with-lease*) echo "reviewer: a branch is never force-pushed" >&2; exit 2 ;;
  *"git rebase"*|*"git -"*" rebase"*) echo "reviewer: a branch is never rebased; merge instead" >&2; exit 2 ;;
esac
exit 0
