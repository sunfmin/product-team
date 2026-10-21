# Showing the proof is whole

Each saving carries the checks below that apply to it. The PR that makes the saving shows their
output, before and after.

## The tests that exist

List every test by its full name before and after (the framework's list or collect-only mode).
The lists match. A test renamed or two merged into one are listed as pairs, old to new, with the
assertions of each old test found in the new one.

## What each test asserts, and on what

For each test the change touches, compare before and after:
- its assertions — none removed, none loosened (a range widened, an exact match made partial,
  an error kind made "any error");
- its inputs — the same sizes, the same number of cases and runs. A property test keeps its case
  count and its shrinking; a fuzz test its corpus and time;
- its dependencies — a real database, filesystem, process or network service stays real. A real
  one replaced by a fake is a deletion unless the test was never about that dependency, and the
  PR says what else exercises it for real.

A property or fuzz test may run in two tiers — a fixed seed and a modest case count in the gate,
the full count on a schedule — only when both counts are written down and each tier runs where it
says.

## The bugs it catches

Run mutation testing on the code the touched tests cover, before and after, with the same tool and
settings. The mutants killed do not go down. How to run it and read survivors: the
`test-rigor-review` skill's `techniques/mutation.md`.

Use it for every saving that changes a test's body, inputs or dependencies. A saving that only
changes how artifacts are built or where the tests run, and leaves every test body as it is,
needs only the list check and the repeat check.

## Runs that agree

A change to ordering, sharing or parallelism: run the touched tests, at the suite's full
parallelism, many times (20 or more, or as many as fit in the time the saving buys). Every run
passes. One failure is a race the change made, or one it exposed; either way it is fixed before
the saving counts.

## Moving a check to compile time

A run-time check and its tests may go when a type, a schema the build validates, or a proof the
build checks now holds the same rule. The PR names it and shows the bad value can no longer be
written: a test that fails to compile, a schema the build rejects, the proof's statement. The
`spec-rigor-review` skill finds these moves and judges whether one holds.
