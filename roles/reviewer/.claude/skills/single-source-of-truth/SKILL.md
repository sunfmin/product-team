---
name: single-source-of-truth
description: Language-agnostic engineering philosophy for eliminating drift and double-apply bugs — one authoritative home per fact, derive/generate the rest, declare desired state over imperative steps, idempotent convergence, make illegal states unrepresentable, colocate truth with the thing, gate unavoidable hand-sync, and extract proven-reused logic into a shared package (earning the abstraction via the Rule of Three). Each rule carries its root-cause rationale. Use when designing config/schemas/DSLs/codegen/migrations/build-systems/shared libraries, when reviewing code with copy-pasted constants, hand-synced docs, name-keyed side tables, read-modify-write counters, run-once-only operations, or the same logic copied across repos/teams, and when user mentions 幂等 idempotent, 声明式 declarative, single source of truth, DRY, drift, convergence, derive, extract a reusable package, premature/wrong abstraction, Rule of Three.
---

# Single Source of Truth

Caveman. Deep rules + WHY each exists.

## The one root cause

Every bug below is the same shape: **a correctness duty got parked on human
memory** — "remember to update both", "remember it already ran", "remember to
call the check". Humans forget; the duty decays monotonically. **Every rule
here moves one duty off a human and onto a mechanism that cannot forget**
(compiler, type, engine, derivation, test). That is the whole philosophy. Pick
the mechanism per case.

A second lens: **collapse the distance between a truth and its uses.** Each gap
— a copy, a hand-sync, a manual step, a runtime check — is a place two things
can disagree. Close the gap so disagreement is impossible, not merely
discouraged.

This is old wisdom under one roof. The meta-rule's ancestors: **poka-yoke**
(Toyota — shape the jig so the part can't go in backwards), **the pit of
success** (make the right thing the default), and Alexis King's **"parse, don't
validate"** — *"every time you check something and don't encode the result in a
type, you're asking your future self to remember."* Each rule below names its
own lineage; the full catalog + cross-domain examples are in
[EXAMPLES.md](EXAMPLES.md).

## Rules, each with its root problem

**1. Knowledge has ONE home.** (Real DRY — about knowledge, not lines.)
*Lineage:* DRY (Hunt & Thomas); DB normalization / the update anomaly (Codd).
*Why:* two copies can only be kept equal by discipline — nothing structural
forbids them diverging, and divergence is SILENT until it bites. One home →
"they disagree" is not expressible. Watch: same constant in code+DB+docs;
validation in client+server; enum twice.

**2. Derive or generate the rest.**
*Lineage:* content-addressed storage (Git/Nix); the spreadsheet formula cell.
*Why:* a copy is a snapshot frozen at copy-time; the source moves on and the
copy has no way to know. A derivation has no memory TO go stale — it recomputes
from the home every time. Need the fact elsewhere → compute it / generate the
artifact (views, codegen, walk-the-tree). A second hand-written list mirroring
the first is a drift bomb on a timer.

**3. Declare desired state, not steps.**
*Lineage:* declarative programming (SQL/Make/React); level- vs edge-triggered (k8s).
*Why:* imperative steps secretly assume a starting state; run them from a
different state and they corrupt it. A declaration names the destination and
lets the engine find the path from wherever-you-actually-are — so it survives
partial/unknown states. Bonus: a declaration can be diffed, validated,
visualized; a script can only be run. (Terraform, k8s, SQL, React.)

**4. Idempotent. Re-run = same world.**
*Lineage:* exactly-once is impossible → at-least-once + idempotent (Two Generals/FLP); HTTP PUT; event sourcing.
*Why:* the real world only delivers at-least-once — retries, crashes,
double-clicks, redeliveries are unavoidable. You CANNOT buy exactly-once
delivery; you can only buy exactly-once *effect*, and only by making the op
idempotent. Then at-least-once becomes safe. So: apply = converge to declared
state, no "did this run?" branch. Sync/generate cmd: second run = zero change,
and TEST it. Counters: fold a log to derive the count — read→+1→write isn't
crash-atomic, replay double-applies. Cache/cursor = derived view; world never
derived from cursor.

**5. Make illegal states unrepresentable.**
*Lineage:* Minsky's slogan (Jane Street/OCaml); "parse, don't validate" (King); null = the billion-dollar mistake (Hoare).
*Why:* a runtime check trusts every present and future caller to remember to
call it — one forgotten call site = bug. A type trusts no one; the guarantee
holds for callers not yet written. Pushing the guarantee earlier (runtime →
compile → can't-even-write-it) shrinks both the window the bug can live in and
the count of places you must patrol — toward zero. When a refactor makes a bug
class impossible, DELETE its guard test and say so: the structure now holds the
line.

**6. Colocate truth with the thing.**
*Lineage:* referential integrity / foreign keys; locality.
*Why:* a side table keyed by name is a JOIN maintained by hand — it has two
failure modes a field can't have (key with no thing = orphan; thing with no key
= missing) plus a stringly-typed key that can typo. A field ON the struct is a
join the compiler maintains; orphan/missing become unrepresentable (rule 5 for
associations). Put the fact at the definition site, not in `map[name]Fact`.

**7. Hand-sync unavoidable? Gate the drift.**
*Lineage:* generate-then-verify-in-CI; drift detection (`terraform plan`); golden tests; lockfiles.
*Why:* sometimes a copy genuinely can't be removed — a human-readable doc beside
the code, a generated artifact committed for offline use. The copy is forced,
so its freshness can't rest on you. Generate one FROM the other into
marker-delimited blocks, and a test FAILS when stale. This converts "human must
remember to re-sync" (decays) into "build is red" (cannot be ignored) — rule 1
when you can't have rule 1.

**8. Reused, small, stable? Give it ONE home as a package — depend, don't copy. But EARN it.**
*Lineage:* DRY across boundaries; Unix "do one thing well" (McIlroy). The brake:
Rule of Three (Roberts/Fowler), "duplication is far cheaper than the wrong
abstraction" (Metz), AHA — Avoid Hasty Abstractions (Dodds).
*Why:* this is rule 1 pushed ACROSS a boundary (module/repo/team). A copy in
another repo is the worst drift — the person who'd "remember to update the other
copy" doesn't know it exists; cross-boundary duplication is INVISIBLE drift. A
package makes the home discoverable and updates ride a version bump.
**But this is the ONE rule with a brake** — extraction also buys a new gap, the
dependency edge (version skew, a breaking change ripples to every consumer). Net
win only when the thing is small + STABLE: a churning interface becomes a shared
abstraction everyone bends with flags until it's a tangle, and the fix is to
inline it back (Metz). So EARN it: duplicate until the **third** use reveals the
real shape, THEN extract. A wrong/early abstraction costs more than the
duplication it replaced. And don't package a one-liner whose dependency cost
exceeds the copy (leftpad). Extract because it's *proven reused and stable*, not
merely *reusable*.

## Smell → which duty is parked on a human → move

- copy-paste constant → "update all copies" → one home, import (1)
- doc table mirrors code → "re-sync the doc" → generate + drift test (2,7)
- `if alreadyDone { skip }` → "know if it ran" → converge instead (4)
- read-modify-write counter → "don't double-apply" → append + fold (4)
- `map[name]Thing` beside the things → "keep keys in step" → field on thing (6)
- runtime "must be one of" → "call the check everywhere" → enum/type it (5)
- "remember to update both" comment → that IS the smell → generate one (2,7)
- same logic copied into a 3rd repo/team → invisible cross-boundary drift → extract a package, but only now it's earned (8)

## Worked example: Go builder DSL

One construct hits 1,3,5,6 at once: builder with UNEXPORTED fields,
constructor = the noun (`Agent("po")`), setters named for what they set + return
the builder, interpreter reads via `GetX()`.

```go
PO = Agent("po").Prompt("po.tmpl").Returns(Accept, Continue, GiveUp).
	Facts(AgentFacts{Round: true})   // fact ON the agent (6), not a side map
```

Render the contract doc FROM these declarations into `<!-- BEGIN x -->…<!-- END
x -->`; a drift test fails if stale (2,7). The verdict set is the type's closed
contract, checked once at startup, not re-checked per call site (5).

## Same rules, other domains (teaser — full catalog in EXAMPLES.md)

Terraform/k8s = 3+4. DB migrations = 4. Event sourcing = 4 (state folded from
log). Protobuf/OpenAPI codegen = 2. Foreign keys / NOT NULL = 5+6. Rust borrow
checker = 5 (data races don't compile). Stripe idempotency keys = 4. Spreadsheet
formula vs typed number = 2. Recognize the move in a new domain → [EXAMPLES.md](EXAMPLES.md).
