# The product team

A team that builds the whole product an issue describes, now. One role builds; one decides what the builder cannot, so a human is asked almost never. There is no review stage: the gate is the review of each change, the `review` patrol reviews the code as it stands, and the `test-speed` patrol measures where the tests' time goes, each opening what is worth building as issues. Whatever the fleet would hand a human, the lead is asked first: a builder's `escalate`, and anything that went wrong.

A ruling becomes a precedent once it is proposed and lands in `precedents.md`. A human's ruling is proposed after one issue: the fleet starts the lead with `record-precedent` and it opens the PR. The lead's own ruling is proposed once the lead has given the same ruling on two different issues: in the consult that gives it the second time, the lead follows `record-precedent` and opens an issue on this repo that appends the entry, since a consult may not push, and this repo's fleet lands it.

Every role supports Claude Code, Codex and Kimi Code; the builder also supports pi, and no role supports DSH yet.

Each role keeps its own refusal script because a worker receives only that role's directory; its harnesses call that script, and the gate exercises each role's hooks to keep their refusals alike.

```yaml
escalate_label: ready-for-human
roles:
  builder: ./roles/builder
  lead: ./roles/lead
  reviewer: ./roles/reviewer
  timekeeper: ./roles/timekeeper
precedents: { by: lead, do: record-precedent, max_open: 10 }
split: false
```

| Role | What it does | Where |
|---|---|---|
| `builder` | Builds an issue whole, test first, gates it, and lands it | stage `build`; landing |
| `lead` | Stands where a human would for whatever the fleet would hand one: looks into it and decides, for the complete product, now; proposes a ruling as a precedent: a human's after one issue, its own once it gave the same ruling on two issues | consult; precedents |
| `reviewer` | Reviews the code as it stands for deep modules first, by the three design skills, and opens what is worth building as tickets; writes no code | patrol `review` |
| `timekeeper` | Measures where the tests and the gate spend their time by `test-speed-review`, and opens the savings that keep every test's proof whole as tickets; writes no code | patrol `test-speed` |
