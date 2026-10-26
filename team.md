# The product team

A team that builds the whole product an issue describes, now. One role builds; one decides what the builder cannot, so a human is asked almost never. There is no review stage: the gate is the review of each change, the `review` patrol reviews the code as it stands, and the `test-speed` patrol measures where the tests' time goes, each opening what is worth building as issues. Whatever the fleet would hand a human, the lead is asked first: a builder's `escalate`, and anything that went wrong.

Every role supports Claude Code, Codex, Kimi Code and pi; no role supports DSH yet.

Each role keeps its own refusal script because a worker receives only that role's directory; its harnesses call that script, and the gate exercises each role's hooks to keep their refusals alike.

```yaml
escalate_label: ready-for-human
roles:
  builder: ./roles/builder
  lead: ./roles/lead
  reviewer: ./roles/reviewer
  timekeeper: ./roles/timekeeper
split: false
```

| Role | What it does | Where |
|---|---|---|
| `builder` | Builds an issue whole, test first, gates it, and lands it | stage `build`; landing |
| `lead` | Stands where a human would for whatever the fleet would hand one: looks into it and decides, for the complete product, now | consult |
| `reviewer` | Reviews the code as it stands for deep modules first, by the three design skills, and opens what is worth building as tickets; writes no code | patrol `review` |
| `timekeeper` | Measures where the tests and the gate spend their time by `test-speed-review`, and opens the savings that keep every test's proof whole as tickets; writes no code | patrol `test-speed` |
