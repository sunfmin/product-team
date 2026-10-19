#!/bin/sh
# Refuses what a builder never does, whatever it was asked: see CLAUDE.md.
call=$(cat)
case "$call" in
  *--no-verify*) echo "builder: a commit is never made with --no-verify" >&2; exit 2 ;;
  *"push --force"*|*"push -f "*|*--force-with-lease*) echo "builder: a branch is never force-pushed" >&2; exit 2 ;;
  *"git rebase"*) echo "builder: a branch is never rebased; merge instead" >&2; exit 2 ;;
esac
exit 0
