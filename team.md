# The product team

A team that builds the whole product an issue describes, now. One role builds; one decides what the builder cannot, so a human is asked almost never. There is no review stage: the gate is the review. Whatever the fleet would hand a human, the lead is asked first: a builder's `escalate`, and anything that went wrong.

```yaml
escalate_label: ready-for-human
roles:
  builder: ./roles/builder
  lead: ./roles/lead
precedents: { by: lead, do: record-precedent, max_open: 10 }
```

| Role | What it does | Where |
|---|---|---|
| `builder` | Builds an issue whole, test first, gates it, and lands it | stage `build`; landing |
| `lead` | Stands where a human would for whatever the fleet would hand one: looks into it and decides, for the complete product, now; proposes a human's ruling as a precedent | consult; precedents |
