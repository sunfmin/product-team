# afkconvoy config

How the afkconvoy fleet works this repo's backlog: issues labelled
`ready-for-agent`, each an edit to the team (its rules, roles, skills,
workflows, patrols or precedents). The repo is unbound: it is the team other
repos bind to, so its own workers are afkconvoy's stock ones, and a hand-off
goes to afkconvoy's stock consult first.

```yaml
base_branch: main
gate_command: ./gate.sh
gate_seconds: 300
ready_label: ready-for-agent
concurrency: 2
escalate_label: ready-for-human
```

The gate (`gate.sh`) exercises each role's Claude Code, Codex and Kimi Code
refusal hooks from an isolated role directory, then checks that the team,
read from the worktree, still loads: `team.md`, the workflows and the patrols.
The hook checks use `jq` and refuse unsafe git commands while allowing normal
commits, pushes and merges. `afkconvoy check` reads each role from GitHub at
the default branch's head, so its team-loading check does not validate local
edits to a role's own files (its `CLAUDE.md`, its skills, its hooks). For
such an edit, also read the changed files against `afkconvoy help roles` and
`afkconvoy help skill-file`, and say in the PR what was checked; the first
`afkconvoy check` after it lands checks it for real.

A change here reaches every bound repo's next worker (bizkernel, wxread): a
role's text is followed as written, by nobody reviewed. Keep each rule one
sentence that says what to do, and say in the PR which observed run it fixes.
