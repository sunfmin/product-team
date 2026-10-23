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

The gate (`gate.sh`) checks that the team, read from the worktree, still
loads. `afkconvoy check` reads each role from GitHub at the default branch's
head, so an edit to a role's own files is not seen by the gate; check it by
hand before declaring done:

```sh
afkconvoy check --team sunfmin/product-team
```

once the PR is pushed is not enough either, as it reads the default branch.
Read the edited role's files against `afkconvoy help roles` and
`afkconvoy help skill-file` instead, and say in the PR what was checked.

A change here reaches every bound repo's next worker (bizkernel, wxread): a
role's text is followed as written, by nobody reviewed. Keep each rule one
sentence that says what to do, and say in the PR which observed run it fixes.
