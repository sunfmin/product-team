# Measuring a suite

## A quiet machine

A number taken beside other work is noise. Before the baseline, check the machine's load and
what else is building or testing on it (other worktrees, a CI runner, a fleet of agents). If
something heavy shares the machine, wait for it, run under the host's exclusive-run mechanism
if it has one, or say in the report that the numbers are loaded and by what.

Run the suite once to warm caches, then measure the next run. Report both when the cold run is
what CI or a fresh worktree actually pays: a cache only a warm machine has saves nothing there.

## The split

Total time alone points at nothing. Split it into:

- **build** — compiling the code, the tests and every artifact the tests use (binaries, modules,
  generated code, images);
- **setup** — what runs before a test's own checking: starting services, creating databases,
  running migrations, loading fixtures, spawning helper processes;
- **run** — the tests' own checking;
- **teardown** — stopping, cleaning, deleting.

Take build from the build tool's timing output. Take setup and teardown from the test framework's
fixture timing where it has one; otherwise time one test with an empty body and subtract.

## The slowest list

List the ten slowest tests and the ten slowest build units by name, with seconds. Use the
ecosystem's own timing output, for example:

- Rust — `cargo nextest run` (per-test times, slow-test reporting), `cargo build --timings`
- Python — `pytest --durations=0`
- Go — `go test -json` (each test's `Elapsed`), `go build -x` timing per package
- JavaScript — the runner's verbose or JSON reporter (`jest --verbose`, `vitest --reporter=json`)
- JVM — Gradle `--scan` or the build's test report

Learn the exact flags from the project's own scripts and the tool's help, not from memory.

## Wall time and the critical path

With parallel tests, the total is the longest chain, not the sum. Note which tests and steps lie
on that chain: a saving off it changes nothing until the chain shortens.
