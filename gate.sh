#!/bin/sh
# The fleet's gate for this repo: the team, read from this checkout as an
# edit of sunfmin/product-team, still loads. `afkconvoy check` reads the
# roles themselves from GitHub at the default branch's head, so a change to
# a role's files is checked once it has landed, by the next run's check.
set -e
cd "$(dirname "$0")"
afkconvoy check --dir . --team sunfmin/product-team >/dev/null
echo "gate: the team loads"
