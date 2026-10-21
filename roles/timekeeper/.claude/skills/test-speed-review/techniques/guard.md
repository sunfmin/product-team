# Keeping the time down

A saving with nothing to hold it is spent again within weeks, by tests added one at a time, each
too small to notice.

## What a guard holds

- **The suite's total** — fail, or at least warn loudly, when a run takes more than a set multiple
  of its recorded baseline (1.5× is a usual start), on the machine class the baseline was taken on.
- **Each test** — name every test above a per-test limit in the run's output, so the slow one is
  found the day it lands, not in the next review.
- **The build** — name the build units whose time grew most since the baseline.

## Where the baseline lives

In the repo, next to the gate, with the machine class it holds for, and updated by a deliberate
change that says why. A baseline that moves on its own each run guards nothing.

## How loose

Loose enough that load and cache state alone never trip it; tight enough that one new slow test
does. Measure the spread over a few quiet runs and set the limit above it.

## When a project has none

The first finding of the review is the guard, ranked above every saving: savings without it do not
last.
