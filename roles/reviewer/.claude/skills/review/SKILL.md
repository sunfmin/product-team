---
name: review
description: Review the repo's code by codebase-design, complexity-review and single-source-of-truth, and open what is worth building as tickets, sliced by to-tickets. Use when the brief you were started with names `review` as the skill to perform.
---

# review

1. **Read what was decided.** The repo's own rules, its glossary and its ADRs; the team's precedents; the open issues, and the issues closed in the last month. Load `codebase-design`, `complexity-review`, `single-source-of-truth` and `to-tickets`.
2. **Choose where to look.** All of the code is yours. Start from what changed most: what landed on the base branch since the last day, then the modules changed most over the last month, then the largest. Go as wide as you can review well; depth on a few places beats a glance at all of them.
3. **Review each place through the three skills**, and write down each finding with its place, the principle it breaks, what you counted that shows it, and the change that fixes it.
4. **Hold every finding to the bar of your rules.** Drop what misses it, what an open issue covers, and what an ADR, the glossary, a precedent or a closed issue settled the other way.
5. **Slice what is left into tickets by `to-tickets`**: vertical slices, a wide refactor as expand–contract, each ticket with the tickets that block it. Several findings that are one change are one ticket. Open no more than your brief says you have room for; the most valuable first.
6. **Open them, blockers first.** Each with `to-tickets`' issue template, and a section saying it was found by the review patrol, with the principle and what you counted. Open each with no label; set its blocking edges as GitHub dependencies and in its body's `## Blocked by`; then take it in with the intake line your brief gives, to the team's workflow, with `--blocked-by` for its blockers.
7. **End as your brief says.** Having opened nothing is a fine run: say so, and why, in the last thing you write.
