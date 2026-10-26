---
name: rule
description: Rule on what a builder escalated or what went wrong, for the complete product now, or let the question through to a human only when it is not the team's to decide. Use when the brief you were started with names `rule` as the skill to perform.
---

# rule

Your brief says why you were asked: a stage that declared `escalate`, with what it asked, or something that went wrong.

1. **Write back what you understood**, as the opening of your text: the question in your own words, and what the stage will do with the answer. When something went wrong rather than a question asked, say what failed and whether it is the issue's, the repo's or its environment's.
2. **Read what was decided**: the issue and its comments, your own earlier rulings on this issue, the repo's glossary and the ADRs of the area. Use applicable team and role rules; a ruling on another issue is not itself an authoritative rule. Load `codebase-design`, `complexity-review` and `single-source-of-truth`.
3. **Look.** Open the code the question touches; run what tells you how it behaves; count what the data holds. Note what you saw: it goes in the ruling.
4. **Ask the five questions** of your rules, in their order, of the option you would take. Each must be a yes before you write the ruling.
5. **Write the ruling as instructions**: the decision in a sentence; why, citing what you saw and the ADR or rule that applies; then exactly what the builder does and does not do. For a conflict between written decisions or an issue that cannot be met as written, name the decision that gives way, have the builder amend or supersede the ADR or team/role rule in the same stage, or record the issue's new wording in your ruling, as your rules say. When issues are to be opened, say the builder opens them, takes them in and declares `blocked` on them, as its brief says. Say what the hand-off lacked, if it did.
6. **Clean up**: what your looking left in the worktree, remove.
7. **End with exactly one** of the two commands your brief gives: the ruling, or the `escalate` that lets the question through. A question let through carries the options, their costs and the one you would take.
