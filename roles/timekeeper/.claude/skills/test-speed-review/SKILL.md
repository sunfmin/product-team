---
name: test-speed-review
description: >
  Load this FIRST, before reading any code or running any tests, whenever the user asks
  why a test suite, CI run or pre-merge gate is slow, how to make tests run faster, where
  a suite's time goes, which tests are slowest, or how to stop test time creeping back up.
  Also triggers on "test speed review", "the tests take too long", "speed up the gate",
  "CI is slow", "测试太慢", "怎么让测试跑快点", "gate 太慢", "测试时间都花在哪". It measures where
  a suite's time goes, finds savings that keep every test proving what it proves today,
  states for each the evidence that nothing was weakened, reports ranked findings, and
  changes only what the user then picks. Not for strengthening tests (test-rigor-review),
  not for the speed of the product's own code, and not for a test that fails or flakes
  (diagnosing-bugs).
---

# Test speed review

A suite earns its time by what it proves. This skill makes the suite **fast** and keeps the
**proof** whole: every saving it proposes leaves each test checking what it checked, on
inputs as large, against dependencies as real, catching the same bugs.

Two words carry the skill:

- **Proof** — what the suite establishes: the tests that exist, what each asserts, on what
  inputs, against which dependencies, and the bugs that make it go red.
- **Overhead** — every second of the suite that is not a test's own checking: building,
  setting up, waiting, tearing down, running in a line what could run side by side.

A saving cuts overhead. A change that cuts proof is a deletion, whatever its PR calls it.

## Process

1. **Fix the scope.** The whole suite the user named (the gate, CI, one package's tests). If
   they named nothing, take the command the project runs before a merge, and say which one.
2. **Measure** with `techniques/measure.md`: a baseline on a quiet machine, the time split into
   build, setup, the tests' own run and teardown, and the slowest tests and steps by name. Every
   finding later cites these numbers. A suite that does not build or pass is reported first,
   because nothing can be measured on it.
3. **Find savings** with `techniques/overhead.md`, from the largest measured cost down. Each
   finding names the overhead, the measured seconds it costs, the change, and the seconds it
   should save.
4. **Pair each saving with its proof check** from `techniques/proof.md`: the evidence the PR
   will show that the suite proves what it proved. A saving with no check that can show it is
   left out.
5. **Find the missing guard** with `techniques/guard.md`: what fails or names the culprit when the
   suite's time creeps back up. A suite with no guard gets one as a finding of its own.
6. **Rank** by measured seconds saved ÷ effort; a missing guard ranks first. Drop savings below the project's threshold; when
   the project names none, below 5% of the total or 10 seconds, whichever is smaller.
7. **Report** in the format below, then stop. The review only reads and measures: run the suite
   and its timing tools as they are, and edit nothing until the user picks findings.
8. **Make what the user picked**, one finding at a time. Measure again after each, and run its
   proof check. A saving that misses its proof check is undone, not adjusted until it passes.

## Report format

Open with **The baseline**: the command, the machine and its load, the total, the split into
build / setup / run / teardown, and the ten slowest tests or steps with their seconds.

Then these sections, ranked with the largest saving first. Give each finding an ID. When a
section has none, say so in one line.

- **Savings** (`S`) — location, the overhead, its measured cost, the change, the expected saving,
  the proof check, effort (S/M/L).
- **Moves to compile time** (`C`) — a run-time check, and its tests, that a type, schema or proof
  could hold instead (see `techniques/proof.md`). Name the type or proof that takes it over.
- **Guard** (`G`) — the guard the suite lacks, or the one that is too loose, and what it holds.
- **Not covered** — costs measured but not addressed and why, and savings considered and left out
  because no proof check could show them safe.

Locations are `file:line`. Mark each saving as **estimated** or **measured**; it is measured only
once you ran the changed suite. End with the three things to do first and why.

## Rules that hold throughout

- **Measure, never guess.** A number in the report is one you took in this run, with the command
  that took it.
- **Every test keeps its proof.** Test count, assertions, input sizes, run counts, and the real
  dependencies a test exercises stay as they are; a change to one of them is a deletion.
- **Moving a check to compile time is a move, not a deletion**, only when you name what holds it
  now: a type that cannot express the bad value, a schema the build validates, a proof the build
  checks. Without that name, it is a deletion.
- **Faster and flakier is slower.** Each change that touches ordering, sharing or parallelism is
  run repeatedly before it counts (`techniques/proof.md`).
- **The gate runs the whole suite.** Running only the tests a change affects speeds a developer's
  loop; it never replaces the full run before a merge.

## Before stopping

Check the work against each technique file. Anything in them you skipped gets a stated reason
under **Not covered**.

- `techniques/measure.md` — the baseline, the split, the slowest list, a quiet machine
- `techniques/overhead.md` — where overhead hides and the change that removes each kind
- `techniques/proof.md` — the checks that show a saving kept the proof
- `techniques/guard.md` — keeping the time from creeping back
