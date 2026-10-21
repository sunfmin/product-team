# Lineage & cross-domain examples

The seven rules are not new — they are one face each of principles named across
50 years of computing (and older, in manufacturing). This file grounds each
rule in its lineage and lists where you've already seen it. Read it to recognize
the SAME move in an unfamiliar domain.

## The meta-rule's ancestors

"Move the correctness duty off human memory onto a mechanism that can't forget":

- **Poka-yoke** (Shigeo Shingo, Toyota) — mistake-proofing. Shape the jig so the
  part physically cannot be inserted backwards. The physical-world rule 5.
- **The pit of success** (Rico Mariani / Jeff Atwood) — make the correct thing the
  easy, default, fall-into-it thing; make the wrong thing hard or impossible.
- **Parse, don't validate** (Alexis King, 2019) — "every time you check something
  and don't encode the result in a type, you're asking your future self to
  remember." That sentence IS the meta-rule.

## Rule 1 — Knowledge has one home

*Descends from:* **DRY** (Hunt & Thomas, *The Pragmatic Programmer*, 1999): "every
piece of knowledge must have a single, unambiguous, authoritative representation."
**Database normalization** (Codd, 1970): redundancy causes the **update anomaly** —
data changed in one place, stale in another. Normalization = one home per fact.

Seen as: a config value read from one place, not copied per service · a CSS
variable / design token vs the same hex pasted 40 times · a DB column, not the
same field denormalized into three tables · 12-Factor config · one enum
definition shared by code and DB.

## Rule 2 — Derive or generate the rest

*Descends from:* normalization again (a JOIN re-derives; you don't store the
joined copy); **content-addressed storage** (the id IS a hash of the content, so
the name can't disagree with the bytes).

Seen as: a **spreadsheet formula cell** vs a hand-typed number — the formula can't
go stale, the number rots the instant an input changes (the everyday rule 2) ·
**Git / Nix / Docker layers / IPFS** — content hash as identity, automatic dedup,
drift impossible · **protobuf / OpenAPI / GraphQL → codegen** — one schema, many
language clients · **DB views & materialized views** · a **symlink** or DNS
**CNAME** vs a copied file / hardcoded IP · `go generate`.

## Rule 3 — Declare desired state, not steps

*Descends from:* **declarative programming** (SQL, Prolog, Datalog, Make, React) —
say WHAT, the engine finds HOW. **Level-triggered vs edge-triggered** (k8s
reconciliation, Tim Hockin): a level-triggered controller reacts to *state*, not to
*change* — so a lost or duplicated event can't corrupt it. Edge-triggered ("on
change, do X") assumes it saw every change in order; it didn't.

Seen as: **Terraform / Kubernetes / Nix** — declare the world, the engine
converges · a **reconciliation / control loop** (observe → diff desired vs actual →
act) · React's `render(state)` vs hand-mutating the DOM · CSS (declare layout) vs
imperative positioning · SQL `SELECT` vs a hand-written scan loop.

## Rule 4 — Idempotent, re-run = same world

*Descends from:* **exactly-once delivery is impossible** (Two Generals problem, FLP
result). You only get **at-least-once + idempotent processing = "effectively
once."** **HTTP method semantics** (RFC 7231): PUT/DELETE/GET idempotent, POST not.

Seen as: **idempotency keys** (Stripe — retry the charge safely) · the **outbox
pattern** + consumer **dedup** · **event sourcing** — state is a *fold of an
immutable log*, never mutated in place (rules 1+2+4 at once) · **CRDTs** — concurrent
replicas converge · **DB migrations** — each runs once or is written idempotent ·
**reproducible / hermetic builds** (Nix, Bazel) — same inputs, same output, re-run
safe · a **level-triggered** controller (rule 3) is idempotent by construction.

## Rule 5 — Make illegal states unrepresentable

*Descends from:* **"Make illegal states unrepresentable"** (Yaron Minsky, *Effective
ML*, Jane Street, 2010). **"Parse, don't validate"** (Alexis King, 2019).
**Correctness by construction.** The anti-pattern: **null — "the billion-dollar
mistake"** (Tony Hoare) — a value that can be absent everywhere a check was forgotten.

Seen as: **algebraic / sum types** — Rust & Swift `enum`, TS discriminated unions,
Haskell/OCaml ADTs: a loading state that's `Loading | Loaded(data) | Failed(err)`
can't be "loaded but no data" · **newtypes / branded types** — `UserId` ≠ `OrderId`
at compile time · `NonEmpty` list, `PositiveInt` · **DB constraints** — NOT NULL,
UNIQUE, CHECK, FOREIGN KEY: the database refuses the bad row, no app check needed ·
**Rust's borrow checker** — data races aren't a runtime risk, they don't compile ·
**typestate** — a `File` you can't `.read()` until `.open()` returns `OpenFile`.
When a refactor makes the bad state unrepresentable, delete its guard test.

## Rule 6 — Colocate truth with the thing

*Descends from:* **referential integrity / foreign keys** — the DB maintains the
join; you don't copy the joined columns and hope they stay equal. A name-keyed
side table is a hand-maintained join with orphan/missing/typo failure modes a
field doesn't have.

Seen as: a **foreign key** vs duplicating the parent's columns into the child ·
a tagged union carrying its **own discriminant** (the tag and the payload can't
disagree) vs a separate `type` field + `data` blob · a method **on** the object vs
a `switch` on its type name scattered across the codebase · the fact declared at
the struct's definition site vs `map[name]Fact` beside it.

## Rule 7 — Hand-sync unavoidable? Gate the drift

*Descends from:* **generated-code-checked-in + verify-in-CI**; **drift detection**
(`terraform plan` reports observed-vs-declared divergence — rule 3's diff, surfaced).

Seen as: `go generate` then a CI step that fails if `git diff` is non-empty ·
**golden / snapshot tests** · **gofmt / prettier --check** — the canonical form is
generated; a hand-edit that diverges fails CI · **contract tests** (Pact) — provider
and consumer can't drift apart silently · **lockfiles** (`package-lock.json`,
`go.sum`) — pin the resolved truth + verify the hash on install · a marker-block doc
generator with a stale-fails test (this skill's own mechanism).

## Rule 8 — Reused, small, stable? One home as a package

*Descends from:* **DRY across a boundary** — the same "one authoritative
representation" of rules 1/2, but now the copies live in different modules,
repos, or teams, where drift is *invisible* (no one sees the other copies).
**Unix philosophy** (Doug McIlroy): "write programs that do one thing well… expect
the output of every program to become the input to another" — small, composable,
reused units. *The brake:* **Rule of Three** (Don Roberts, popularized by Fowler,
*Refactoring*): "the third time you do something similar, you refactor." **"The
Wrong Abstraction"** (Sandi Metz, RailsConf 2014): *"duplication is far cheaper
than the wrong abstraction"* — the cure for a bad shared abstraction is to inline
it back. **AHA — Avoid Hasty Abstractions** (Kent C. Dodds): the balance between
DRY and WET.

Seen as the right move: **Unix coreutils + pipes** — tiny tools reused by
composition · a language's **standard library** · a **design-tokens** package one
home for color/spacing, many apps · **one schema package** (protobuf/JSON-schema)
imported by every service so request/response types can't drift between them ·
a **platform / shared-libs team** harvesting proven-common code · this session's
own `orchkit` — the product-agnostic engine/DSL extracted out of the `rundays`
product so a second orchestration could host on it · and this very skill, lifted
out of one codebase and published as `npx skills add …` so any repo reuses it.

Seen as the trap (why the brake exists): a **`utils` / `helpers` god-module**
everyone dumps into and no one can change safely · a shared component that grew
**15 boolean flags** because each new caller bent it instead of forking it (Metz's
wrong abstraction) · **leftpad** — an 11-line function packaged as a dependency,
so an unpublish broke half the internet (the dependency edge cost more than the
copy would have) · extracting on the **second** use, before the real shape is
known, then fighting the abstraction on the third.

The test is not "is this reusable?" (almost anything is) but "is it **proven
reused (3+) AND stable enough that the shared interface won't churn**, so that one
home beats the cost of the dependency edge?" Extract what's *earned*, not what's
*conceivable*.

## Adjacent ideas worth knowing

- **Functional core, imperative shell** (Gary Bernhardt) — push decisions into pure
  functions (deterministic, rule 5-friendly, trivially testable), keep I/O at the
  edge. Pure decisions + a thin effectful shell = idempotency is easy to reason about.
- **Single-writer principle** (Martin Thompson) — one owner of a piece of state
  removes a whole class of races (rule 1 for concurrency).
- **Smart data structures, dumb code / Rule of Representation** (Eric Raymond) —
  "fold knowledge into data so program logic can be stupid and robust" (rules 3+6).
