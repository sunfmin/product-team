# review

Reviews the code of the repo for deep modules first, by the three design skills, and opens what is worth building as tickets for the `build` workflow. It is bounded by what it costs the repo: the issues it opened that landed in a day, as well as the issues it has open and its runs in a day. A repo runs it by naming it under `patrols` in its config.

```yaml
by: reviewer
do: review
every: 1h
max_open: 5
max_runs_a_day: 5
max_landed_a_day: 5
```
