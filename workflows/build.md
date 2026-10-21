# build

For every issue an agent is to work, opened as usual with `ready-for-agent`: a feature, a fix, a refactor, a document. One stage builds the issue whole and lands it; whatever the fleet would hand a human — a question the builder cannot decide, or anything that went wrong — the lead takes first, and a human is reached only when the lead lets it through.

```yaml
label: ready-for-agent
max_rework: 3
max_consecutive_rework: 2
stages:
  - name: build
    by: builder
    do: build
    escalate: { to: lead, do: rule }
    on: { pass: land }
land: { by: builder, do: land }
```
