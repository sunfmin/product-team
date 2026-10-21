# Where overhead hides

Ordered by the saving each usually yields. Look for every kind; report the ones the baseline
shows are large.

## 1. The same work done again

An artifact built once per test, per test process or per test file, when one build per run would
serve all: compiled binaries or modules, generated code, container images, seeded data, a
downloaded fixture.

Change: build it once per run, before the first test, into a place every test reads. When tests
run in parallel and also build, make building happen in turns or ahead of time, so no test reads
an artifact another is rewriting.

## 2. A fixed cost on every case

Each test case starts a service, creates a database, runs migrations, installs a schema or loads
the same fixture.

Change, cheapest first:
- share the fixture across the cases that only read it;
- copy a prepared template (a template database, a snapshot, a copied directory) instead of
  rebuilding it;
- run each case in a transaction rolled back at its end;
- keep one service up for the run and give each case its own namespace in it.

A case that writes shared state gets its own copy; sharing it is a test-order bug.

## 3. Sleeping instead of waiting

A fixed sleep, or a poll with a fixed interval, stands in for a condition. It is slow when the
condition comes early and flaky when it comes late.

Change: wait on an observable signal — a line in a log, an event, a port accepting, a file
appearing — with a deadline. Where the code waits on time itself, give it a clock the test
controls.

## 4. The build profile

Tests built without optimisation spend their time in dependencies doing heavy work (crypto,
compression, policy engines, parsers, runtimes). The same crate or package built several times
in one run under different settings. One slow build unit on the critical path.

Change: optimise the heavy dependencies only, in the test profile; make one run build each unit
once; split or trim the build unit that dominates the critical path.

## 5. Running in a line

Tests forced to run one at a time because they share a port, a directory, an environment
variable, a global or a database.

Change: give each test its own (an ephemeral port, a temp directory, its own database or
schema), then let them run side by side. This is the kind most likely to add a race: its proof
check runs the suite repeatedly at full parallelism.

## 6. Slow checks in the checker

A static checker, prover or type checker that spends most of its time on a few items (a refinement
type checker on a few functions, a linter on generated code).

Change: find those items from the tool's own timing output and make them smaller — split the
function, the specification or the loop. Raising the tool's time limit is not a saving.

## 7. Running only what changed

For a developer's loop only: select the tests a change can affect. It is not a saving for the
gate, which runs the whole suite.
