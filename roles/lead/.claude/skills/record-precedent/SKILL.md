---
name: record-precedent
description: Propose a ruling as an entry of the team's precedents — a human's ruling on an escalated issue, or the lead's own once it has given the same ruling on two different issues. Use when the brief you were started with names `record-precedent` as the skill to perform, or when, in a consult, the ruling you are giving is one you already gave on another issue.
---

# record-precedent

Whose ruling may be proposed: a human's, after one issue; your own, as the lead, only once you have given the same ruling, in substance, on two different issues. A ruling of yours given once is not proposed.

Started for it, your brief quotes the ruling, names the team's repo and the branch to open the PR from, and gives the form of an entry: follow its form and its hard rules to the letter, as a PR that does anything else is closed. In a consult, the ruling is the one you are giving, the team's repo is `sunfmin/product-team`, and the form is the one below.

1. **Read the issue and the escalation** the ruling answers: what was asked, and why no stage and no consult could decide it. For your own ruling, read your earlier one too, and name both.
2. **Is there a precedent in it?** There is when the question will come up again on another issue, and the ruling would be the same there. A ruling that only settles this issue has none: propose nothing, and stop.
3. **Read the precedents kept**, in `precedents.md` of the team's repo at its default branch. One that covers the case already: propose nothing, cite it, and stop.
4. **Word the entry.** One line a stage can act on: the situation, then what to do. Add **When:** where it applies, where that is narrower than the sentence, and the link to every ruling it came from, in parentheses: `- <situation, then what to do>. **When:** <where it applies>. (<link>, <link>)`
5. **Propose it.**
   - Started for it: in a clone of the team's repo of your own, outside the checkout: `gh repo clone <team> <a new directory under $TMPDIR>`, the branch your brief names, the one line appended at the end of the precedents file, commit, push the branch, `gh pr create`. The PR's body quotes the ruling and links the issue. A human merges it, or does not.
   - In a consult, which may not push: first look for an open issue on the team's repo that already proposes it (`gh issue list --repo sunfmin/product-team --state open --search "precedent"`); one does: comment the link of this ruling on it, and open none. Otherwise `gh issue create --repo sunfmin/product-team --label ready-for-agent`, titled `Record a precedent: <the situation>`, whose body gives the entry line exactly as it is to be appended, links both rulings, and has as its one acceptance criterion that the line is appended at the end of `precedents.md`. The team's fleet builds and lands it.
6. **Stop**, or, in a consult, go back to ending the consult as `rule` says.
