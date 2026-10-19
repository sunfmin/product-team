---
name: build
description: Build an issue whole in its worktree, test first, open its PR and turn the gate green. Use when the brief you were started with names `build` as the skill to perform.
---

# build

1. **Read everything first**: the issue, every comment on it, the stage records your brief lists, the precedents, and what the branch already holds. When the brief has a `Rework` or a ruling, read it first: a ruling is followed to the letter.
2. **Read the domain**: the repo's glossary and the ADRs of the area you touch. Use their words; break none of their decisions. Load the design skills you have (`codebase-design`, `single-source-of-truth`, `complexity-review`, `domain-modeling`, `tdd`) when they are there.
3. **Sort what the issue needs.** List every acceptance criterion and what each needs to be true. For each gap: inside the issue's purpose, it is part of this build; outside it, open its issue now, take it in, and declare `blocked` (your rules). A decision nobody made: `escalate` with a hand-off.
4. **Test first**, then the code, in steps that each stand. A message says what its commit does, in the imperative.
5. **Finish it**: the docs, help text, glossary entries and ADR the change makes true or stale, in the same branch.
6. **Review your own diff** against the design skills above. Fix what you find; a finding whose fix is outside the issue is an issue you open now, linked from the PR.
7. **Open the PR**, once, against the base branch your brief names. Its body:

   ```
   Closes #<the issue>

   ## What changed
   ## How it was verified
   The commands run, and what each printed.
   ## Not verified
   ## Issues opened
   ```

   A PR that is open already is not opened again: push to its branch.
8. **Turn the gate green**, with the command and in the way your brief says.
9. **Declare `pass`**. The text: what changed, by commit; what was verified and how; what was not; which issues you opened.
