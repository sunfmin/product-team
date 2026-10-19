---
name: rule
description: Rule on what a builder escalated, for the complete product now, or let the question through to a human only when it is not the team's to decide. Use when the brief you were started with names `rule` as the skill to perform.
---

# rule

A stage declared `escalate`. Your brief quotes what it asked.

1. **Write back what you understood**, as the opening of your text: the question in your own words, and what the stage will do with the answer. If the hand-off is too thin to rule on, look yourself (step 3) before giving up on it.
2. **Read the precedents, the issue and its comments, the repo's glossary and the ADRs of the area.** Load the design skills you have (`codebase-design`, `single-source-of-truth`, `complexity-review`, `domain-modeling`) when they are there.
3. **Look.** Open the code the question touches; run what tells you how it behaves; count what the data holds. Note what you saw: it goes in the ruling.
4. **Decide**, as your rules say, in their order. Is it one of the four a human is asked? If not, it is yours.
5. **Write the ruling as instructions**: the decision in a sentence; why, citing what you saw, the ADR or the precedent; then exactly what the builder does: which issues to open (title, what to build, acceptance criteria, what blocks what), what to build in this one, and what not to do. When issues are to be opened, say the builder opens them, takes them in and declares `blocked` on them, as its brief says.
6. **End with exactly one** of the two commands your brief gives: the ruling, or the `escalate` that lets the question through. A question let through carries the options, their costs and the one you would take.
