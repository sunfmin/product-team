# build

For every issue: a feature, a fix, a refactor, a document. One stage builds the issue whole and lands it; when it cannot decide, the lead rules, and a human is reached only when the lead lets the question through.

```yaml
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
