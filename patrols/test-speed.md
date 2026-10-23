# test-speed

Measures where the repo's test suite and gate spend their time by `test-speed-review`, and opens the savings that keep every test's proof whole as tickets for the `build` workflow. Each run and each issue it opens spend a bounded number of the host's exclusive runs, and a guard it sets has its limits measured under the host's admitted load, both as the timekeeper's rules say. A repo runs it by naming it under `patrols` in its config.

```yaml
by: timekeeper
do: speed-review
every: 1h
max_open: 2
max_runs_a_day: 3
```
