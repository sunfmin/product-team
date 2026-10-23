---
name: build
description: Build an issue whole in its worktree, test first, open its PR and turn the gate green. Use when the brief you were started with names `build` as the skill to perform.
---

# build

1. **Read everything first**: the issue, every comment on it, the stage records your brief lists, the precedents, and what the branch already holds. When the brief has a `Rework` or a ruling, read it first: a ruling is followed to the letter.
2. **Read the domain**: the repo's glossary and the ADRs of the area you touch. Use their words; break none of their decisions. Then load, before any code, `codebase-design`, `complexity-review` and `single-source-of-truth`, whatever the issue: every build designs or changes the system. Load each in a call of its own: by your harness's way of invoking a skill if it has one, and otherwise by reading its `SKILL.md`, one skill per command, then the files it names; when the output was cut short, read the rest before you go on. You are given every skill of the host you run on, beside your role's: read the list and load, the same way, each other one whose description fits this work too: the language's toolchain and test conventions, `domain-modeling`, `tdd`, and any the repo's rules name. A skill for the web or a browser (such as `agent-reach` or `computer-use`), for an app or service the issue does not touch, or for the host user's own chores fits no build unless the issue needs it: leave it unread.
3. **Sort what the issue needs.** List every acceptance criterion and what each needs to be true. For each gap: inside the issue's purpose, it is part of this build; outside it, open its issue now, take it in, and declare `blocked` (your rules), once you have checked that the issue you block on is not already blocked on this one; when it is, `escalate` with a hand-off that names both. A decision nobody made: `escalate` with a hand-off. A question the issue hands over, to the builder, the lead or anyone: answer it here if your rules and the precedents settle it, and `escalate` with it if they do not; never drop it as out of scope.
4. **Test first**, then the code, in steps that each stand. A message says what its commit does, in the imperative. A single test runs as it is; a full suite, a full build, a benchmark or a stress loop runs as `afkconvoy exclusive -- <command>`, every time.
5. **Finish it**: the docs, help text, glossary entries and ADR the change makes true or stale, in the same branch.
6. **Review your own diff** against the skills you loaded, before you commit it: `complexity-review`'s red flags, `codebase-design`'s depth and seams, `single-source-of-truth`'s one home per fact, each in turn. Fix what you find; a finding whose fix is outside the issue is an issue you open now, linked from the PR.
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
8. **Turn the gate green**, with the command and in the way your brief says, as the brief writes it, never wrapped in `exclusive` again. Stay in your turn until it has finished and you have read its result: run it in the foreground with a time limit that covers it, or in the background with its output to a file, then wait on it with bounded foreground checks until it has finished. Your run ends with your turn, and nothing wakes you when a background command finishes.
9. **Declare `pass`**. The text: what changed, by commit; what was verified and how; what was not; which issues you opened.
