---
name: speed-review
description: Measure where the repo's test suite and gate spend their time by test-speed-review, and open what is worth building as tickets, sliced by to-tickets. Use when the brief you were started with names `speed-review` as the skill to perform.
---

# speed-review

1. **Read what was decided.** The repo's own rules, its glossary and its ADRs; the team's precedents; the open issues, and the issues closed in the last month, those about test or gate time above all. Load `test-speed-review`, and read `to-tickets`' `SKILL.md`: both are your role's own (your rules).
2. **Find the suite.** The command the repo runs before a merge (its gate) is the scope. Read it and the scripts it calls, so you know its steps.
3. **Measure** by `test-speed-review`'s Process steps 2 to 6, every measurement under `afkconvoy exclusive --`, within your run's bound of exclusive runs, as your rules say. Write down the baseline, its split and the slowest tests and steps with their seconds.
4. **Hold every finding to the bar of your rules.** Drop what misses it, what an open issue covers, and what an ADR, the glossary, a precedent or a closed issue settled the other way.
5. **Slice what is left into tickets by `to-tickets`**: its rules for vertical slices and for blocking edges, and its issue template. Several findings that are one change are one ticket. Its steps that wait on a person are yours, as your rules say: check the breakdown against its rules yourself. Open no more than your brief says you have room for; the missing guard first, then the largest saving.
6. **Open them, blockers first.** Each with `to-tickets`' issue template. Its acceptance criteria hold the saving's proof check and the seconds it should save, measured by the same command, within its bound of full measurement runs, and the issue states its queue cost, as your rules say. Add a section saying it was found by the speed-review patrol, with the baseline, the command and what else ran on the host. Open each with no label; set its blocking edges as GitHub dependencies and in its body's `## Blocked by`; then take it in with the intake line your brief gives, to the team's workflow, with `--blocked-by` for its blockers.
7. **End as your brief says.** Having opened nothing is a fine run: say so, and why, in the last thing you write, with the baseline you measured.
